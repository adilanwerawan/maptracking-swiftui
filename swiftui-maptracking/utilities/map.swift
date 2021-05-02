//
//  map.swift
//  assign4
//
//  Created by Adil Anwer on 26/04/2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    // 1.
    //    @State var trackPoints: [MapPin]
    @ObservedObject var locationManager: LocationManager
    @Binding var shouldShowAnnotation:Bool
    // 2.
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.514134, longitude: -0.104236),
        span: MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075))
    
    
    var body: some View {
        
        if shouldShowAnnotation{
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: locationManager.pointsOfInterest){place in
                MapMarker(coordinate: place.coordinate)
            }
            .ignoresSafeArea(.all)
            .onAppear(){
                if locationManager.pointsOfInterest.count > 0{
                    let point = locationManager.pointsOfInterest[0]
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:  point.coordinate.latitude, longitude: point.coordinate.longitude),span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                }
            }
            
        } else {
            Map(coordinateRegion: $region,showsUserLocation: true, userTrackingMode: .constant(.follow))
                .ignoresSafeArea(.all)
                .onAppear(){
                    if locationManager.pointsOfInterest.count > 0{
                        let point = locationManager.pointsOfInterest[0]
                        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:  point.coordinate.latitude, longitude: point.coordinate.longitude),span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    }
                }
        }
    }
}

struct TracksMap: View {
    // 1.
    @State var trackPoints: [MapPin]
    
    // 2.
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.514134, longitude: -0.104236),
        span: MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075))
    
    
    var body: some View {
        
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: trackPoints){place in
            MapMarker(coordinate: place.coordinate)
        }
        .ignoresSafeArea(.all)
        .onAppear(){
            let point = trackPoints[0]
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:  point.coordinate.latitude, longitude: point.coordinate.longitude),span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
}

/*
 struct map_Previews: PreviewProvider {
 static var previews: some View {
 map()
 }
 }
 */
