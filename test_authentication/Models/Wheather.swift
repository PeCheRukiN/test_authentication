//
//  Wheather.swift
//  test_authentication
//
//  Created by PeCheRukiN on 17.05.2018.
//  Copyright © 2018 pecherukin. All rights reserved.
//

import Foundation

struct Wheather: Decodable {
    enum TemperatureType {
        case Fahrenheit, Celsius
    }
    
    struct MainData: Decodable {
        var humidity: Int
        var pressure: Int
        var temp: Double
    }
    var main: MainData
    
    func getTemperature(in temperatureType: TemperatureType) -> String {
        var temperature: String = ""
        let celsiusTemp = main.temp - 273.15
        switch temperatureType {
            
        case .Fahrenheit:
            let fahrenheitTemp = (9/5 * celsiusTemp) + 32
            temperature = String(format: "%.0f", fahrenheitTemp) + "º F"
        case .Celsius:                
            temperature = String(format: "%.0f", celsiusTemp) + "º C"
            
        }
        return temperature
    }
}
