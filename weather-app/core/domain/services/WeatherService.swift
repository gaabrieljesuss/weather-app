//
//  WeatherService.swift
//  weather-app
//
//  Created by Gabriel Santos on 24/11/22.
//

import Foundation

class WeatherService: IWeatherService {
    private var weatherAPI: WeatherAPI
    
    required init (weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
    }
    
    func fetchForecast(latitude: Double, longitude: Double) async throws -> Weather {
        return try await weatherAPI.fetchForecast(latitude: latitude, longitude: longitude)
    }
}
