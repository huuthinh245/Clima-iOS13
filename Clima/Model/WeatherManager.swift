//
//  WeatherManager.swift
//  Clima
//
//  Created by thinh on 5/20/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WheatherDelegate {
    func didUpdateWeather(weather: WheatherModel)
}

struct WeatherManager {
     let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=777ef4ddd49d071e2fcbfe5a5fa09958&units=metric"
    var delegate: WheatherDelegate?
    func fetchWeather(cityName: String) {
        
        let urlString = "\(weatherURL)&q=\(cityName.replacingOccurrences(of: " ", with: ""))"
        performRequest(with: urlString)
    }
    
    func fetchWeather(lat: Double, lng: Double) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lng)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task  = session.dataTask(with: url) { (data, res, error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(weatherData: safeData) {
                        print(weather)
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> WheatherModel? {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(WeatherData.self, from: weatherData)
            let id = data.weather?[0].id ?? 0
            let cityName = data.name ?? ""
            let temperature = data.main?.temp ?? 0
            let country = data.sys?.country ?? ""
            let weather = WheatherModel(conditionId: id, cityName: cityName, temperature:temperature, country: country)
            return weather
        }catch {
            print(error)
            return nil
        }
    }
}



