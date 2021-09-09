//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization();
        locationManager.requestLocation()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func locationBtnPressed(_ sender: Any) {
        locationManager.requestLocation();
    }
}


//MARK:-UITextFieldDelegate
extension WeatherViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        searchTextField.endEditing(true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = searchTextField.text {
            weatherManager.fetchWeather(cityName: text)
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        }else {
            searchTextField.placeholder = "type something"
            return false
        }
    }
}
//MARK:-WheatherDelegate
extension WeatherViewController : WheatherDelegate {
    func didUpdateWeather(weather: WheatherModel) {
        print(weather.conditionName)
        DispatchQueue.main.sync {
            temperatureLabel.text = String(weather.temperature)
            cityLabel.text = weather.cityName
            conditionImageView.image = UIImage(systemName: weather.conditionName)
            countryLabel.text = weather.country
            searchTextField.text = weather.cityName
        }
    }
}
//MARK:-CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude;
            weatherManager.fetchWeather(lat: lat, lng: lng)
            print(lat)
            print(lng)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
             print(error)
    }
}
