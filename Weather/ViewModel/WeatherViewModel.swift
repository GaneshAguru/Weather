//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Aguru, Ganesh (Contractor) on 29/05/23.
//

import Foundation

class WeatherViewModel{
    
    
    let shared = WebUtility.shared
    
    
    
    func getWeatherDataVM(lat:Double,long:Double,handler: @escaping ([WeatherList])->Void){
        
        WebUtility.shared.getWeatherData(lat: lat, long: long, handler: handler)
        
    }
    
    
    
    func downloadIconVM(iconName:String,callback: @escaping (URL)->Void){
        
        WebUtility.shared.downloadIcon(iconName: iconName, callback: callback)
        
    }
    
    
}
