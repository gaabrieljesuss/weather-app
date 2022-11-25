//
//  IWeatherService.swift
//  weather-app
//
//  Created by Gabriel Santos on 24/11/22.
//

import Foundation

protocol IWeatherService {
    func fetchForecast(latitude: Double, longitude: Double) async throws -> Weather
}
