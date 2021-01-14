//
//  MapView.swift
//  Fanxis
//
//  Created by Erik Flores on 13/01/21.
//

import SwiftUI
import MapKit

struct FXMapView: View {
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @ObservedObject var viewModel: FXMapViewModel = FXMapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                viewModel.verifyPermissons()
            }
    }
}

struct FXMapView_Previews: PreviewProvider {
    static var previews: some View {
        FXMapView()
    }
}
