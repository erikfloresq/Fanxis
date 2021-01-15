//
//  MapView.swift
//  Fanxis
//
//  Created by Erik Flores on 13/01/21.
//

import SwiftUI
import MapKit

struct Point: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct FXMapView: View {
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @ObservedObject var viewModel: FXMapViewModel = FXMapViewModel()
    @GestureState var isDetectingLongPress = false
    @State var completedLongPress = false
    @State var points: [Point] = [
        Point(coordinate: .init(latitude: 12.3, longitude: 12.3)),
        Point(coordinate: .init(latitude: 12.3, longitude: 12.3))
    ]
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: points, annotationContent: { point in
                MapPin(coordinate: point.coordinate)
            })
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                viewModel.verifyPermissons()
            }.gesture(longPressGesture)
    }
    
    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 3)
            .updating($isDetectingLongPress) { (currentState, gestureState, transaction) in
                gestureState = currentState
            }.onEnded { finished in
                self.completedLongPress = finished
            }
    }
    
}

struct FXMapView_Previews: PreviewProvider {
    static var previews: some View {
        FXMapView()
    }
}
