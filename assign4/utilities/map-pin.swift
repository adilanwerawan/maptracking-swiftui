//
//  map-pin.swift
//  assign4
//
//  Created by Adil Anwer on 26/04/2021.
//

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation, Identifiable {

    let id:UUID = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let action: (() -> Void)?

    init(coordinate: CLLocationCoordinate2D,
         title: String? = nil,
         subtitle: String? = nil,
         action: (() -> Void)? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
}
