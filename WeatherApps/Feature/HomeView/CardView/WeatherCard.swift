//
//  WeatherCard.swift
//  WeatherApps
//
//  Created by Avows Technology on 01/03/26.
//

import SwiftUI

struct WeatherCard: View {
    let weather: WeatherResponse?
    let useFarenheit: Bool 
    var iconWeatherUrl: String {
        guard let icon = weather?.current?.condition?.icon else { return "" }
        return "https:\(icon)"
       
    }
    
    var displayTemperature: String {
        guard let tempC = weather?.current?.tempC, let tempF = weather?.current?.tempF else { return "--" }
        return useFarenheit ? String(format: "%.1f°F", tempF) : String(format: "%.1f°C", tempC)
        
    }
    
    var displayFeelsLike: String {
        guard let feelsLikeC = weather?.current?.feelslikeC, let feelsLikeF = weather?.current?.feelslikeF else { return "--" }
        return useFarenheit ? String(format: "%.1f°F", feelsLikeF) : String(format: "%.1f°C", feelsLikeC)
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: iconWeatherUrl)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                case .failure(_):
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.secondary)
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                @unknown default:
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            }
            
            Text("\(weather?.location?.name ?? ""), \(weather?.location?.country ?? "") ")
                .font(.title)
                .bold()
            Text("Temperature \(displayTemperature)")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
            
            Text(weather?.current?.condition?.text ?? "")
                .font(.headline)
                .bold()
                .foregroundStyle(.white.opacity(0.9))
            
            Text("Feel Like  \(displayFeelsLike)")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(colors: [.blue, .teal], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(.rect(cornerRadius: 20))
        .shadow(radius: 10)
        .padding()
    }
}

//#Preview {
//    WeatherCard()
//}
