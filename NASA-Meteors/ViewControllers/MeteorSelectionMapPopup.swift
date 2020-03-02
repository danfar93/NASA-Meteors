//
//  MeteorSelectionMapPopup.swift
//  NASA-Meteors
//
//  Created by Daniel Farrell on 02/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import UIKit
import MapKit

class MeteorSelectionMapPopup: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var meteorSelectionMapView: MKMapView!
    @IBOutlet var popupBackgroundView: UIView!
    
    let regionInMeters: Double = 150000
    let locationManager = CLLocationManager()
    
    var selectedMeteorName = String()
    var selectedMeteorLat = String()
    var selectedMeteorLong = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSelectedMeteorToMap()
    }
    
    
    /*
     * Adds selected meteor annotation to
     * the map view popup
     */
    func addSelectedMeteorToMap() {
        let annotation = MKPointAnnotation()
        annotation.title = selectedMeteorName
        annotation.subtitle = selectedMeteorName
        let lat = Double(selectedMeteorLat)
        let long = Double(selectedMeteorLong)
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
        meteorSelectionMapView.addAnnotation(annotation)
        let region = MKCoordinateRegion.init(center: annotation.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        meteorSelectionMapView.setRegion(region, animated: true)
    }
    
    
    func setupView() {
        popupBackgroundView.layer.cornerRadius = 15
        popupBackgroundView.clipsToBounds = true
    }
    
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }

}
