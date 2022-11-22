//
//  WeatherViewModel.swift
//  weather-app
//
//  Created by user230124 on 11/22/22.
//

import Foundation
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published private var weather: Weather?
    @Published private var isNight: Bool = false
    
    private var weatherAPI: WeatherAPI
    
    required init(weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
    }
    
    func fetchWeather() {
        Task { @MainActor in
            do {
                self.weather = try await weatherAPI.getTemperature(latitude: -9.75164, longitude: -36.6604)
            } catch let error as WeatherError {
                print(error.message)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    var dayWeatherListView: some View {
        ForEach(1...5, id: \.self) { index in
            let temperature = self.weather?.weeklyForecast.temperatures[index]
            if let temperature = temperature {
                WeatherDayView(dayOfWeek: "TUE", imageName: getWeatherImageByTemperature(temperature: Int(temperature)), temperature: Int(temperature))
            }
        }
    }
    
    var mainWeatherStatusView: some View {
        MainWeatherStatusView(
            imageName: self.isNight ? "moon.stars.fill" : "cloud.sun.fill",
            temperature: self.weather?.currentWeather.temperature != nil ? Int((self.weather?.currentWeather.temperature)!) : 0)
    }
    
    var weatherButton: some View {
        Button {
            self.isNight.toggle()
        } label: {
            WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
        }
    }
    
    var backgroundView: some View {
        BackgroundView(isNight: self.isNight)
    }
}

struct WeatherDayView: View {
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 12) {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .frame(width: 40, height: 40)
                .aspectRatio(contentMode: .fit)
            Text("\(temperature)º")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct MainWeatherStatusView: View {
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("\(temperature)º")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }.padding(.bottom, 40)
    }
}

struct BackgroundView: View {
    
    var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea(.all)
    }
}

func getWeatherImageByTemperature(temperature: Int) -> String {
    if temperature >= 28 {
        return "sun.max.fill"
    } else if temperature <= 20 && temperature > 14 {
        return "cloud.rain.fill"
    } else if temperature <= 14 && temperature > 8 {
        return "wind"
    } else if temperature <= 8 {
        return "snowflake"
    }
    return "cloud.sun.fill"
}
