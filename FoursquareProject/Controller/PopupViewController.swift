//
//  File.swift
//  FoursquareProject
//
//  Created by Ömer Faruk Fildişi on 27.06.2019.
//  Copyright © 2019 Ömer Faruk Fildişi. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class PopupViewController: UIViewController {
    
    var ven: VenueResponseModel?
    var photo: String?
    var venueId = String()
    
    
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        getMap()
        venueId = (ven?.id)!
        getPhotosData(venueId: venueId)
        getTips(venueId: venueId)
        //getTips(venueId: "51d95bf0498eee1e7944f0e1")
        nameLabel.text = ven?.name
        
    }
   
    
    func getMap(){
        if ven != nil {
            let location = CLLocationCoordinate2DMake((ven?.location?.lat)!, (ven?.location?.lng)!)
            let span = MKCoordinateSpan(latitudeDelta: 0.2,longitudeDelta: 0.2)
            let locationRegion = MKCoordinateRegion(center: location, span: span)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = ven?.name
            map.setRegion(locationRegion, animated: false)
            map.addAnnotation(annotation)
            
            
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func getPhotosData(venueId: String) {
        /*
        
        var urlString = "https://api.foursquare.com/v2/venues/\(venueId)/photos?client_id=ZP4PCUE4WG1XHZJ4F05B2WR0MU30GIH35GUCY0GRI3O0XLWI&client_secret=ZGHWC0UXSFPM5SERDS1YNXEINGEHTMXRL1NXE0UGAFYCFUIV&v=20190614"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: urlString) else  { return }
        // print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, _,err) in
            
            //guard let data = data else { return }
          
            if let dat = data {
                do {
//                    print(String(data: dat, encoding: .utf8))
                    let result = try JSONDecoder().decode(FoursquareResponsePhotosModel.self, from: dat)
                    if result.response?.photos != nil {
                        let imageUrlString = (result.response?.photos?.items![0].prefix!)! + "300x300" + (result.response?.photos!.items![0].suffix!)!
                    
                        self.photo = imageUrlString
                     
                        let imageUrl:URL = URL(string: imageUrlString)!
                        DispatchQueue.main.async {
                            let imageData:NSData = NSData(contentsOf: imageUrl)!
                            let image = UIImage(data: imageData as Data)
                            self.imageView.image = image
                            }
                    }
                } catch let error {
                    print("There is an error => \(error)")
                }
            }
        }
        task.resume()
        */
        
        let provider = ServiceProvider<VenueServices>()
        
        provider.load(service: .photo(venueId: venueId), decodeType: FoursquareResponsePhotosModel.self){
            result in
            switch result {
            case .success(let result):
                print(result)
                if result.response?.photos != nil {
                    let imageUrlString = (result.response?.photos?.items![0].prefix!)! + "300x300" + (result.response?.photos!.items![0].suffix!)!
                    
                    self.photo = imageUrlString
                    
                    let imageUrl:URL = URL(string: imageUrlString)!
                    DispatchQueue.main.async {
                        let imageData:NSData = NSData(contentsOf: imageUrl)!
                        let image = UIImage(data: imageData as Data)
                        self.imageView.image = image
                    }
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            case .empty:
                print("No data")
            }
        }
    }
 
    func getTips(venueId: String) {
        /*
        var urlString = "https://api.foursquare.com/v2/venues/\(venueId)/tips?&client_id=ZP4PCUE4WG1XHZJ4F05B2WR0MU30GIH35GUCY0GRI3O0XLWI&client_secret=ZGHWC0UXSFPM5SERDS1YNXEINGEHTMXRL1NXE0UGAFYCFUIV&v=20190614"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(urlString)
        
        guard let url = URL(string: urlString) else  { return }
        // print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, _,err) in
            
            //guard let data = data else { return }
            if let responseData = data {
                do {
                    let result = try JSONDecoder().decode(FoursquareResponseTipsModel.self, from: responseData)
                    DispatchQueue.main.async {
                        self.textView.text = result.response?.tips?.items[0].text
                        
                    }
                } catch let error {
                    print("There is an error => \(error)")
                }
            }
        }
        
        task.resume()
        */
        
        let provider = ServiceProvider<VenueServices>()
        
        provider.load(service: .tips(venueId: venueId), decodeType: FoursquareResponseTipsModel.self){
            result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.textView.text = result.response?.tips?.items[0].text
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            case .empty:
                print("No data")
            }
        }
    }
                    

    @IBAction func dismissPopup(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    

}
