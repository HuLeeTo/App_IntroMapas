//
//  DireccionesViewController.swift
//  App_IntroMapas
//
//  Created by formador on 17/2/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import CoreLocation

class DireccionesViewController: UIViewController {
    
    //MARK: - Variables locales
    var locationManager = CLLocationManager()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myLatitudLBL: UILabel!
    @IBOutlet weak var myLongitudLBL: UILabel!
    @IBOutlet weak var myRumboLBL: UILabel!
    @IBOutlet weak var myVelocidadLBL: UILabel!
    @IBOutlet weak var myAltitudLBL: UILabel!
    @IBOutlet weak var myDireccionLBL: UILabel!
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DireccionesViewController : CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let userLocation = locations.first{
            
            myLatitudLBL.text = "\(userLocation.coordinate.latitude)"
            myLongitudLBL.text = "\(userLocation.coordinate.longitude)"
            myRumboLBL.text = "\(userLocation.course)"
            myVelocidadLBL.text = "\(userLocation.speed)"
            myAltitudLBL.text = "\(userLocation.altitude)"
            
            
            CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) in
                
                if error != nil{
                    print(error?.localizedDescription)
                }else{
                    if let placemarkDes = placemarks?[0]{
                        
                        var direccion = ""
                        
                        direccion += self.addInfoMap(placemarkDes.thoroughfare)
                        direccion += self.addInfoMap(placemarkDes.subThoroughfare)
                        direccion += self.addInfoMap(placemarkDes.subLocality)
                        direccion += self.addInfoMap(placemarkDes.subAdministrativeArea)
                        direccion += self.addInfoMap(placemarkDes.isoCountryCode)
                        direccion += self.addInfoMap(placemarkDes.country)
                        direccion += self.addInfoMap(placemarkDes.postalCode)
                        direccion += self.addInfoMap(placemarkDes.locality)
                        direccion += self.addInfoMap(placemarkDes.ocean)
                        self.myDireccionLBL.text = direccion
                        
                    }
                }
                
            })
            
            
            
        }
        
        
        
        
        
    }
    
    func addInfoMap(_ info : String?) -> String {
        
        if info != nil{
            return "\(info!) \n"
        }
        
        return ""
    }
    
    
    
}











