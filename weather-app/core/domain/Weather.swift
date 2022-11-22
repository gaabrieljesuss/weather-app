//
//  Weather.swift
//  weather-app
//
//  Created by user230124 on 11/21/22.
//

import Foundation

struct Weather: Decodable {
    
    
    struct CurrentWeather: Decodable {
        var temperature: Float
    }
    
    struct WeeklyForecast: Decodable {
        var dates: [String]
        var temperatures: [Float]
        
        enum CodingKeys: String, CodingKey {
            case dates = "time"
            case temperatures = "temperature_2m_max"
        }
    }
    
    var currentWeather: CurrentWeather
    var weeklyForecast: WeeklyForecast
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.weeklyForecast = try values.decode(WeeklyForecast.self, forKey: .daily)
        
        for index in 0..<weeklyForecast.dates.count {
            weeklyForecast.dates[index] = weeklyForecast.dates[index].components(separatedBy: "-")[1...].reversed().joined(separator: "/")
        }
        
        self.currentWeather = try values.decode(CurrentWeather.self, forKey: .todayWeather)
    }
    
    enum CodingKeys: String, CodingKey {
        case daily
        case todayWeather = "current_weather"
    }
}
