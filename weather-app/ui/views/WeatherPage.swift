
//
//  ContentView.swift
//  weather-app
//
//  Created by user230124 on 11/17/22.
//

import SwiftUI


struct WeatherPage: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    init() {
        self.viewModel = WeatherViewModel(weatherAPI: WeatherAPI())
        self.viewModel.fetchWeather()
    }
    
    var body: some View {
        ZStack {
            viewModel.backgroundView
            VStack {
                CityTextView(cityName: "Arapiraca, AL")
                
                viewModel.mainWeatherStatusView
                
                HStack(spacing: 20) {
                    viewModel.dayWeatherListView
                    
                }
                Spacer()
                
                viewModel.weatherButton
                
                Spacer()
            }
        }
    }
}

struct WeatherPage_Previews: PreviewProvider {
    static var previews: some View {
        WeatherPage()
    }
}

struct CityTextView: View {
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium))
            .foregroundColor(.white)
            .padding()
    }
}
