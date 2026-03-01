//
//  WeatherService.swift
//  WeatherApps
//
//  Created by Avows Technology on 01/03/26.
//

import Foundation
import OSLog

enum WeatherError: Error, LocalizedError {
    case invalidResponse
    case decodingError
    case requestFailed(statuCode: Int)
    case uknown
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from the weather API"
        case .decodingError:
            return "Failed to decode the weather data"
        case .requestFailed(let statuCode):
            return "Request failed. Status code: \(statuCode). try again later."
        case .uknown:
            return "An unknown error occured"
        }
    }
}

final class WeatherService {
    private let logger = Logger(subsystem: "com.yourapp.weather", category: "network")
    
    private var API_KEY: String = "Your API KEY"
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        //Build Url
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(API_KEY)&q=\(city)&aqi=no"
        logger.info("Requesting weather data")
        guard let url = URL(string: urlString) else {
            logger.error("Invalid URL")
            throw WeatherError.invalidResponse
        }
        
        do {
            // Fecth Data
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Validate Response
            guard let httpResponse = response as? HTTPURLResponse else {
                logger.error("Invalid HTTP response")
                throw WeatherError.uknown
            }
            
            logger.info("Status code: \(httpResponse.statusCode)")
            
            guard 200..<300 ~= httpResponse.statusCode else {
                logger.error("Server error with status code: \(httpResponse.statusCode)")
                throw WeatherError.requestFailed(statuCode: httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decoded = try decoder.decode(WeatherResponse.self, from: data)
            
            logger.info("Weather decode success")
            
            return decoded
            
        } catch {
            logger.error("Request failed: \(error.localizedDescription)")
            throw WeatherError.decodingError
        }
        
    }
}

