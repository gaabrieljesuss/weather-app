//
//  IWeatherAPI.swift
//  weather-app
//
//  Created by Gabriel Santos on 24/11/22.
//

import Foundation

protocol IWeatherAPI {
    func fetchForecast(latitude: Double, longitude: Double) async throws -> Weather
}
