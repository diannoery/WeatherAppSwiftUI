//
//  WeatherViewModel.swift
//  WeatherApps
//
//  Created by Avows Technology on 01/03/26.
//

import Foundation

@Observable
@MainActor
class WeatherViewModel {
    var searchText: String = ""
    var isLoading: Bool = false
    var weatherData: WeatherResponse?
    var errorMessage: String?
    private var weatherService = WeatherService()
    
    func getWeather() async {
            do {
                isLoading = true
                weatherData = try await weatherService.fetchWeather(for: searchText)
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
            }
    }
}
