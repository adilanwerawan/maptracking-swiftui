//
//  HomeMapView.swift
//  assign4
//
//  Created by Adil Anwer on 25/04/2021.
//

import SwiftUI
import MapKit

struct HomeMapView: View {
    @StateObject var locationManager: LocationManager = LocationManager()
    @State var play:Bool = false
    @State var show = false
    var body: some View {
        GeometryReader{
            reader in
            VStack{
                TrackingMapView(locationManager: locationManager, shouldShowAnnotation: $play)
                    .frame(height:reader.size.height * 0.80)
                OptionsView(locationManager: locationManager, play: $play, shouldShow: $show)
                    .frame(height:reader.size.height * 0.20)
            }
            .frame(width:reader.size.width)
        }
        .onAppear(){
        }
        .onReceive(NotificationCenter.default.publisher(for:Notification.Name.fileSaveNotification), perform: { (output) in
            var points = [GPXPoint]()
            if play{
                for pin in locationManager.pointsOfInterest{
                    let cord = pin.coordinate
                    points.append(GPXPoint(latitude: cord.latitude, longitude: cord.longitude, altitude: 0.0, time: Date()))
                }
                DocumentDirectoryFilesFunctions.save(toDirectory: DocumentDirectoryFilesFunctions.documentDirectory(), withFileName: String("\(Date())"), tracks: points)
                print(FileManager.default.urls(for: .documentDirectory) ?? "none")
            }
        })
        .sheet(isPresented: $show, onDismiss: {
            print("")
        }){
            if let urls = FileManager.default.urls(for: .documentDirectory){
                FilesView(show: $show, data: urls)
            }
        }
    }
}


/*
 struct HomeMapView_Previews: PreviewProvider {
 static var previews: some View {
 HomeMapView()
 }
 }*/
