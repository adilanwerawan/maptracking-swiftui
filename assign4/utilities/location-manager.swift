//
//  LocationManager.swift
//  assign4
//
//  Created by Adil Anwer on 25/04/2021.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion()
    var pointsOfInterest:Array<MapPin> = Array<MapPin>()
    @Published var speed:Double = 0.0
    private let manager = CLLocationManager()
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 5.0
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            speed = $0.speed
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            region = MKCoordinateRegion(center: center, span: span)
            
//            if locations.first!.distance(from: $0) > 1.0{
                
            pointsOfInterest.append(MapPin(coordinate: CLLocationCoordinate2D(latitude: center.latitude,
                                                                              longitude: center.longitude),
                                               title: "",
                                               subtitle: "",
                                               action: { } ))
//            }
        }
    }
}

struct AnnotatedItem: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

/*
class LocationManager: NSObject, ObservableObject {

    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()

    @Published var location: CLLocation?
    @Published var placemark: CLPlacemark?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func geoCode(with location: CLLocation) {

        geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.placemark = placemark?.first
            }
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        DispatchQueue.main.async {
            self.location = location
            self.geoCode(with: location)
        }

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // TODO
    }
}*/
