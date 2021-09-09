//
//  WeatherData.swift
//  Clima
//
//  Created by thinh on 5/20/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    var coord: Coord?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var timezone: Int?
    var id: Int?
    var name: String?
   // var cod: Int?
}

struct Coord: Codable {
    var lon: Double?
    var lat: Double?
}

struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Main: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var humidity: Int?
}

struct Wind: Codable {
    var speed: Double?
}

struct Clouds: Codable {
    var all: Int?
}

struct Sys: Codable {
    var type: Int?
    var id: Int?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
}
