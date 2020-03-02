//
//  MeteorMapViewController.swift
//  NASA-Meteors
//
//  Created by Daniel Farrell on 02/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import UIKit
import MapKit

class MeteorMapViewController: UIViewController {
    
    var meteorsFromAPI = [Meteor]()
    let regionInMeters: Double = 100000
    let locationManager = CLLocationManager()
    
    @IBOutlet var meteorMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        meteorNetworkCall()
        checkLocationServices()
    }
    

    
    /*
     * Checks if the user has authotised location
     * persmissions for the map view
     */
    func checkLocationAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            meteorMapView.showsUserLocation = true
            centerViewUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    
    /*
     * Make call to NASA API and populate map view with
     * meteors that fell after 1900
     */
    func meteorNetworkCall() {
        let service = MeteorNetworking()
        service.retrieveMeteorsFromAPI() { meteors in
            for meteor in meteors {
                let formatter = StartDateFormatter()
                let startDate = formatter.formatDate()
                if (meteor.year ?? startDate > startDate) {
                    self.meteorsFromAPI.append(meteor)
                }
            }
            DispatchQueue.main.async{
                self.addMeteorsToMap()
            }
        }
    }
    
    
    /*
     * Populates map view with custom annotations
     */
    func addMeteorsToMap() {
        for meteor in meteorsFromAPI {
            let annotation = MKPointAnnotation()
            if (meteor.latitude != nil) {
                annotation.title = meteor.name
                if (meteor.mass != nil) {
                    let mass = "\(meteor.mass ?? "")g"
                    annotation.subtitle = mass
                }
                let lat = Double(meteor.latitude!)
                let long = Double(meteor.longitude!)
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
                meteorMapView.addAnnotation(annotation)
            }
        }
    }

    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorisation()
        } else {
            // error handling
        }
    }
    
    
    /*
     * Center the Map View around the users location
     */
    func centerViewUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            meteorMapView.setRegion(region, animated: true)
        }
    }
    
    
}



extension MeteorMapViewController: CLLocationManagerDelegate, MKMapViewDelegate  {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorisation()
    }
    
    
    /*
     * Creates custom annotation for map view
     */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MeteorPin"
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "nasa-pin.png")
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }

}




