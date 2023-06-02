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
    
    
    override func viewDidAppear(_ animated: Bool) {
        let connection = weatherVM.isConnected
     
        if connection{
    
        }else{
            let alert = UIAlertController(title: "No Internet", message: "You are not connected to the Internet. Turn On!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Mobile Data", style: .default,handler: { action in
                print("Mobile data turned on..")
                
                
           let path = UIApplication.openSettingsURLString
                let pathnew = URL(string: path)
                UIApplication.shared.open(pathnew!)
                
                
            }))
            alert.addAction(UIAlertAction(title: "Wifi", style: .default,handler: { action in
                print("Wifi enabled...")
            }))
            alert.addAction(UIAlertAction(title: "close", style: .destructive))
            show(alert, sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var shouldAutorotate : Bool { return false }
        
    }



    fileprivate func getCoordAndNavigate(_ place: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(place) { geoData, _ in
            let lat:Double
            let long:Double
            lat = geoData?[0].location?.coordinate.latitude ?? 0
            long = geoData?[0].location?.coordinate.longitude ?? 0
            
            
            let coordinates = [lat,long]
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailsvc") as! DetailsVC
            vc.latLong = coordinates
            self.present(vc, animated: true)
            
        }
    }
    
    @IBAction func citySearch(_ sender: UIButton) {
        
        let place = searchL.text ?? ""
        print(place)
        
        getCoordAndNavigate(place)
    }
    
    
    @IBAction func topCityClick(_ sender: UIButton) {
    
        let selectedCity :String?
        selectedCity =  sender.titleLabel?.text
        
        getCoordAndNavigate(selectedCity ?? "")
        
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
        
        let coordinates = [lat,long]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailsvc") as! DetailsVC
        vc.latLong = coordinates
        
        self.present(vc, animated: true)
        
    }
    
    
    @IBAction func modeChange(_ sender: UIButton) {
       
    }
    
}


    
    
   
    
    


