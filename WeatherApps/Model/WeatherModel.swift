//
//  WeatherModel.swift
//  WeatherApps
//
//  Created by Avows Technology on 01/03/26.
//

import Foundation

struct WeatherResponse: Codable {
    let location: Location?
    let current: Current?
}

struct Location: Codable {
    let name: String?
    let region: String?
    let country: String?
    let lat: Double?
    let lon: Double?
    let tzId: String?
    let localtimeEpoch: Int?
    let localtime: String?
}

struct Current: Codable {
    let lastUpdatedEpoch: Int?
    let lastUpdated: String?
    let tempC: Double?
    let tempF: Double?
    let isDay: Int?
    let condition: Condition?
    let windMph: Double?
    let windKph: Double?
    let windDegree: Int?
    let windDir: String?
    let pressureMb: Double?
    let pressureIn: Double?
    let precipMm: Double?
    let precipIn: Double?
    let humidity: Int?
    let cloud: Int?
    let feelslikeC: Double?
    let feelslikeF: Double?
    let windchillC: Double?
    let windchillF: Double?
    let heatindexC: Double?
    let heatindexF: Double?
    let dewpointC: Double?
    let dewpointF: Double?
    let visKm: Double?
    let visMiles: Double?
    let uv: Double?
    let gustMph: Double?
    let gustKph: Double?
    let shortRad: Int?
    let diffRad: Int?
    let dni: Int?
    let gti: Int?
}

struct Condition: Codable {
    let text: String?
    let icon: String?
    let code: Int?
}
