//
//  DetailsVC.swift
//  Weather
//
//  Created by Aguru, Ganesh (Contractor) on 26/05/23.
//

import UIKit


protocol ChosenDegrees{
    func degreeSelected(str:String)
}

class DetailsVC: UIViewController {
    
    var delegate : ChosenDegrees!
    
    var weatherVM = WeatherViewModel()
    
    var latLong : [Double] = []
    var placeName : String = ""
    
    var fetchedData : [WeatherList]? = nil
    var weatherIconVM = WeatherViewModel()
    
    

    @IBOutlet weak var changeDegreesSC: UISegmentedControl!
    
    @IBOutlet weak var minmaxL: UILabel!
    @IBOutlet weak var mainTempL: UILabel!
    @IBOutlet weak var placeL: UILabel!
    @IBOutlet weak var weatherDescL: UILabel!
    
    @IBOutlet weak var iconIV: UIImageView!
    
    
    //weather details labels
    @IBOutlet weak var apparentTempL: UILabel!
    @IBOutlet weak var visibilityL: UILabel!
    @IBOutlet weak var airPressureL: UILabel!
    @IBOutlet weak var directionL: UILabel!
    @IBOutlet weak var humudityL: UILabel!
    @IBOutlet weak var windSpeedL: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       let lat = latLong[0]
       let long = latLong[1]

        weatherVM.getWeatherDataVM(lat: lat, long: long, units: "metric") { weatherArray in
            let temp = String(weatherArray[0].main.temp)
            let apparentTemp = String(weatherArray[0].main.feels_like)
            let minTemp = String(weatherArray[0].main.temp_min)
            let maxTemp = String(weatherArray[0].main.temp_max)
            let name = String(weatherArray[0].name)
            
            DispatchQueue.main.async {
                self.mainTempL.text = "\(temp) °C"
                self.dataAssigning()
                self.apparentTempL.text = apparentTemp
                self.minmaxL.text = "\(minTemp)°C/\(maxTemp)°C"
                self.placeL.text = name
            }
        }
       
    }
    

    
    func dataAssigning(){
        
        let lat = latLong[0]
        let long = latLong[1]
        
        weatherVM.getWeatherDataVM(lat: lat, long: long, units: "") { weatherArray in
            let visibility = String(weatherArray[0].visibility)
            let windSpeed = String(weatherArray[0].wind.speed)
            let humidity = String(weatherArray[0].main.humidity)
            let direction = String(weatherArray[0].wind.deg)
            let airP = String(weatherArray[0].main.pressure)
            let description = String(weatherArray[0].weather[0].description)
            let icon = String(weatherArray[0].weather[0].icon)
            
            DispatchQueue.main.async {
                self.visibilityL.text = visibility
                self.windSpeedL.text = windSpeed
                self.humudityL.text = humidity
                self.directionL.text = direction
                self.airPressureL.text = airP
                self.weatherDescL.text = description
                            }
            
            self.weatherIconVM.downloadIconVM(iconName: icon) { url in
                let iconData = try! Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.iconIV.image = UIImage(data: iconData)
                }
            }
            
        }
        
    }
    
    
    
    @IBAction func changeDegreesAction(_ sender: UISegmentedControl) {
    
        let lat = latLong[0]
        let long = latLong[1]
        
        switch sender.selectedSegmentIndex{
            
        case 0:
            weatherVM.getWeatherDataVM(lat: lat, long: long, units: "metric") { weatherArray in
                let temp = weatherArray[0].main.temp
                let apparentTemp = String(weatherArray[0].main.feels_like)
                let minTemp = String(weatherArray[0].main.temp_min)
                let maxTemp = String(weatherArray[0].main.temp_max)
                let str = String(temp)
                DispatchQueue.main.async {
                    self.mainTempL.text = "\(str) °C"
                    self.apparentTempL.text = apparentTemp
                    self.dataAssigning()
                    self.minmaxL.text = "\(minTemp)°C/\(maxTemp)°C"
                }
            }
            
            
        case 1:
            weatherVM.getWeatherDataVM(lat: lat, long: long, units: "imperial") { weatherArray in
                let temp = weatherArray[0].main.temp
                let apparentTemp = String(weatherArray[0].main.feels_like)
                let minTemp = String(weatherArray[0].main.temp_min)
                let maxTemp = String(weatherArray[0].main.temp_max)
                let str = String(temp)
                DispatchQueue.main.async {
                    self.mainTempL.text = "\(str) °F"
                    self.apparentTempL.text = apparentTemp
                    self.dataAssigning()
                    self.minmaxL.text = "\(minTemp)°F/\(maxTemp)°F"
                }
            }
           
        case 2:
            weatherVM.getWeatherDataVM(lat: lat, long: long, units: "default") { weatherArray in
                let temp = weatherArray[0].main.temp
                let apparentTemp = String(weatherArray[0].main.feels_like)
                let minTemp = String(weatherArray[0].main.temp_min)
                let maxTemp = String(weatherArray[0].main.temp_max)
                let str = String(temp)
                DispatchQueue.main.async {
                    self.mainTempL.text = "\(str) °K"
                    self.apparentTempL.text = apparentTemp
                    self.dataAssigning()
                    self.minmaxL.text = "\(minTemp)°K/\(maxTemp)°K"
                }
            }
          
        default:
            break
        }
        
        
    }
    

    
}
