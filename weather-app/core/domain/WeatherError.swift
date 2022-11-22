//
//  WeatherError.swift
//  weather-app
//
//  Created by user230124 on 11/22/22.
//

import Foundation


class WeatherError: LocalizedError {
    var message: String
    
    init(message: String){
        self.message = message
    }
}
