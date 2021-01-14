//
//  LocationManager.swift
//  Fanxis
//
//  Created by Erik Flores on 13/01/21.
//

import Foundation
import CoreLocation
import Combine

protocol LocationManager {
    func verifyPermissons()
    var locations: PassthroughSubject<CLLocation, Never> { get }
}

class FXLocationManager: NSObject, LocationManager {
    private let locationManager = CLLocationManager()
    let locations = PassthroughSubject<CLLocation, Never>()
    
    func verifyPermissons() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
        }
    }
}

extension FXLocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied, .notDetermined, .restricted:
            print("none")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedAlways")
        @unknown default:
            fatalError("Location Manger Error")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            self.locations.send(lastLocation)
        }
    }
}
