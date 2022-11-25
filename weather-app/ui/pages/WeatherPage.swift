
//
//  ContentView.swift
//  weather-app
//
//  Created by user230124 on 11/17/22.
//

import SwiftUI
import CoreLocationUI
import CoreLocation

struct WeatherPage: View {
    @ObservedObject var viewModel: WeatherViewModel
    @StateObject var locationViewModel = LocationViewModel()
    
    init() {
        self.viewModel = WeatherViewModel(weatherAPI: WeatherAPI())
    }
    
    var body: some View {
        ZStack {
            viewModel.backgroundView
            switch locationViewModel.authorizationStatus {
            case .notDetermined:
                AnyView(locationViewModel.requestLocationButton)
            case .restricted:
                ErrorView(errorText: "Location use is restricted.")
            case .denied:
                ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
            case .authorizedAlways, .authorizedWhenInUse:
                if viewModel.hasData() {
                    VStack {
                        locationViewModel.cityTextView
                        
                        viewModel.mainWeatherStatusView
                        
                        HStack(spacing: 20) {
                            viewModel.dayWeatherListView
                            
                        }
                        Spacer()
                        
                        viewModel.weatherButton
                        Spacer()
                    }
                } else {
                    ProgressView()
                        .onAppear() {
                            locationViewModel.addListener(callback: {fetchForecast()})
                        }
                }
            default:
                Text("Unexpected status")
                
            }
        }
    }
    func fetchForecast() -> Void {
        viewModel.fetchWeather(latitude: locationViewModel.lastSeenLocation?.coordinate.latitude ?? 0, longitude: locationViewModel.lastSeenLocation?.coordinate.longitude ?? 0)
    }
}
struct WeatherPage_Previews: PreviewProvider {
    static var previews: some View {
        WeatherPage()
    }
}
