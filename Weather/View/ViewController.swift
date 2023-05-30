//
//  ViewController.swift
//  Weather
//
//  Created by Aguru, Ganesh (Contractor) on 23/05/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var weatherData : [WeatherList] = []
    
    //create a reference to the view model
    var weatherVM = WeatherViewModel()

    @IBOutlet weak var searchL: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("GaneshAguru")
        
    }



    @IBAction func citySearch(_ sender: UIButton) {
        let geoCoder = CLGeocoder()
        let place = searchL.text ?? ""
        print(place)
        
        geoCoder.geocodeAddressString(place) { geoData, _ in
            let lat:Double
            let long:Double
            lat = geoData?[0].location?.coordinate.latitude ?? 0
            long = geoData?[0].location?.coordinate.longitude ?? 0
            

            
            self.weatherVM.shared.getWeatherData(lat: lat, long: long) { weatherArray in
                DispatchQueue.main.async {
                      let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailsvc") as! DetailsVC
                      vc.fetchedData = weatherArray
                      self.present(vc, animated: true)
                }
            }
            
        }
        
        
    }
    
    
    @IBAction func topCityClick(_ sender: UIButton) {
        let geoCoder = CLGeocoder()
        let selectedCity :String?
        selectedCity =  sender.titleLabel?.text
        geoCoder.geocodeAddressString(selectedCity ?? "") { geoData, _ in
            
            let lat = geoData?[0].location?.coordinate.latitude
            let latitude = Double(lat ?? 0)
            let long = geoData?[0].location?.coordinate.longitude
            let longitude = Double(long ?? 0)
            print("Latitude:\(lat!),Longitude:\(long!)")
            

            
            self.weatherVM.shared.getWeatherData(lat: latitude, long: longitude) { weatherArray in
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailsvc") as! DetailsVC
                    vc.fetchedData = weatherArray
                    self.present(vc, animated: true)
                }
            }
            
        }
        
        
        
        
        
    }
    
    
    @IBAction func currentWeatherClick(_ sender: UIButton) {
        
        var currentLocation: CLLocation!
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways{
            currentLocation = locManager.location
        }
     
        
        let lat:Double
        let long:Double
        lat = currentLocation.coordinate.latitude
        long = currentLocation.coordinate.longitude

        
        self.weatherVM.getWeatherDataVM(lat: lat, long: long) { weatherArray in
            DispatchQueue.main.async {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailsvc") as! DetailsVC
                vc.fetchedData = weatherArray
                self.present(vc, animated: true)
            }
        }
        
    }
    
    
    
}

