//
//  ViewController.swift
//  FoursquareProject
//
//  Created by Ömer Faruk Fildişi on 26.06.2019.
//  Copyright © 2019 Ömer Faruk Fildişi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate
{

    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var TypeTf: UITextField!
    @IBOutlet weak var AreaTf: UITextField!
    
    var currentLocation = ""
    
    let locationManager = CLLocationManager()
    var fieldValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
        
        AreaTf.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),
                         for: UIControl.Event.editingChanged)
        
        TypeTf.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),
                         for: UIControl.Event.editingChanged)
        
        customizeButton(searcButton: viewButton)
       
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = manager.location else { return }
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city,  error == nil else { return }
            self.currentLocation = city
            print(self.currentLocation)
        }
    }
    
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
      }
   
    @IBAction func OnSearchTapped(_ sender: Any) {
        
         let type = TypeTf.text
         let area = AreaTf.text
        
        if fieldValid {
            getCityData(type: type!, area: area!)
        }else if area!.isEmpty && !type!.isEmpty{
            getCityData(type: type!, area: currentLocation)
        }else{
            showError()
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        fieldValid =  (TypeTf.text!.count > 2) && (AreaTf.text!.count > 2) && isValidInput(Input: TypeTf.text!) && isValidInput(Input: AreaTf.text!)
    }
    
    func customizeButton(searcButton: UIButton){
        
        searcButton.layer.cornerRadius = 7
      //  searcButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 200)
        
    }

    func isValidInput(Input:String) -> Bool {
        let myCharSet=CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let output: String = Input.trimmingCharacters(in: myCharSet.inverted)
        let isValid: Bool = (Input == output)
        
        return isValid
    }
    
    func showError() {
        let alert = UIAlertController(title: "Error", message: "Please check the fields. Fields must contain at least 2 characters and just the alphabet.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func getCityData(type:String, area: String) {
        
        let provider = ServiceProvider<VenueServices>()
        
        provider.load(service: .search(near: area, query: type), decodeType: FoursquareResponseModel.self){
            result in
            switch result {
            case .success(let response):
                
                if let venues = response.response?.venues {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "inputChanged", sender: venues)
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert1 = UIAlertController(title: "Error", message: "Please check the fields. Fields must contain at least 2 characters and just the alphabet.", preferredStyle: .alert)
                        alert1.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(alert1, animated: true)
                    }
                    
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            case .empty:
                print("No data")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inputChanged" {
            let destination = segue.destination as! ListViewController
                destination.vens = sender as! [VenueResponseModel]
        }
    }
}
