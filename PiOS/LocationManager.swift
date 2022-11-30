//
//  LocationManager.swift
//  PiOS
//
//  Created by David Zirath on 2022-11-23.
//

import Foundation
//import CoreLocation
import MapKit

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.331974, longitude: 18.061059), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    private let manager = CLLocationManager()
    
    @Published var currentLocation: CLLocationCoordinate2D?
    
    
    override init() {
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func getManager() -> CLLocationManager {
        return manager
    }
    
    func askPermission() {
        
        if manager.authorizationStatus != .authorizedWhenInUse {
            
            manager.requestWhenInUseAuthorization()
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Permission has been granted")
            manager.startUpdatingLocation()
            break
        case .notDetermined:
            print("Undertermined permission")
            askPermission()
            break
        case .restricted, .denied:
            print("Application will not work properly until allowing location permission")
            break
        default:
            print("Error, something went wrong.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude,
                                               longitude: $0.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.025,
                                       longitudeDelta: 0.025))
        }
        currentLocation = locations.first?.coordinate
    }
}
