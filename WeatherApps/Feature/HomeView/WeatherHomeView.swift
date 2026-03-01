//
//  WeatherHomeView.swift
//  WeatherApps
//
//  Created by Avows Technology on 01/03/26.
//

import SwiftUI

struct WeatherHomeView: View {
    @State private var viewModel = WeatherViewModel()
    @AppStorage("useFarenheit") private var useFarenheit: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Input City", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button {
                    Task {
                        await viewModel.getWeather()
                    }
                } label: {
                    Label("Get Weather", systemImage: "cloud.fill")
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.searchText.count < 3)
                
                if viewModel.isLoading {
                    ProgressView("Featching Weather...")
                        .padding()
                } else if let weather = viewModel.weatherData {
                    WeatherCard(weather: weather, useFarenheit: useFarenheit)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Spacer()
                
            }
            .navigationTitle("Weather App")
            .toolbar {
                ToolbarItem {
                    Menu {
                        Toggle(isOn: $useFarenheit) {
                            Label(useFarenheit ? "Celsius" : "Farenheit", systemImage: "thermometer.sun" )
                        }
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
        }
       
    }
}

#Preview {
    WeatherHomeView()
}
