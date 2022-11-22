//
//  WeatherAPI.swift
//  weather-app
//
//  Created by user230124 on 11/21/22.
//

import Foundation

class WeatherAPI {
    private let baseURL: String = "https://api.open-meteo.com/v1/forecast"
    
    func getTemperature(latitude: Double, longitude: Double) async throws -> Weather {
        var url = URL(string: self.baseURL)!
        url.append(queryItems: [
                    URLQueryItem(name: "latitude", value: String(latitude)),
                    URLQueryItem(name: "longitude", value: String(longitude)),
                    URLQueryItem(name: "daily", value: "temperature_2m_max"),
                    URLQueryItem(name: "timezone", value: "GMT"),
                    URLQueryItem(name: "current_weather", value: "true"),
        ])
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let statusCode = (response as! HTTPURLResponse).statusCode
        if (statusCode != 200) {
            let answerDict = try JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments
            ) as! [String: Any]
            
            if let reason = answerDict["reason"] {
                throw WeatherError(message: "\(reason)")
            }
        }

        return try JSONDecoder().decode(Weather.self, from: data)
    }
}
