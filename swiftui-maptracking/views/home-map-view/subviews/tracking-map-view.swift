//
//  tracking-map-view.swift
//  assign4
//
//  Created by Adil Anwer on 29/04/2021.
//

import SwiftUI

struct TrackingMapView:View{
    
    @StateObject var locationManager: LocationManager
    @Binding var shouldShowAnnotation:Bool
    @State var pins: [MapPin] = []
    
    var body: some View{
        GeometryReader{
            reader in
            
            MapView(locationManager: locationManager, shouldShowAnnotation: $shouldShowAnnotation)
        }
    }
}

/*
struct tracking_map_view_Previews: PreviewProvider {
    static var previews: some View {
        tracking_map_view()
    }
}*/
