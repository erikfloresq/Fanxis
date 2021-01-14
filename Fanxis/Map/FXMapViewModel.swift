//
//  FXMapViewModel.swift
//  Fanxis
//
//  Created by Erik Flores on 14/01/21.
//

import Foundation
import CoreLocation
import MapKit
import Combine

protocol MapViewModel {
    var region: MKCoordinateRegion { get set }
    func verifyPermissons()
}

class FXMapViewModel: MapViewModel, ObservableObject {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    private var locationManager: LocationManager
    var cancellables = Set<AnyCancellable>()
    
    init(locationManager: LocationManager = FXLocationManager()) {
        self.locationManager = locationManager
    }
    
    func verifyPermissons() {
        locationManager.verifyPermissons()
        locationManager
            .locations
            .sink(receiveValue: { location in
                self.region = MKCoordinateRegion(center: location.coordinate,
                                                 latitudinalMeters: 0.1,
                                                 longitudinalMeters: 0.1)
            })
            .store(in: &cancellables)
        
    }
}
