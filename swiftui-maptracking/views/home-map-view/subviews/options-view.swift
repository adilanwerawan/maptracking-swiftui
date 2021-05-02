//
//  options-view.swift
//  assign4
//
//  Created by Adil Anwer on 26/04/2021.
//

import SwiftUI
import UniformTypeIdentifiers

struct OptionsView:View {
    @StateObject var locationManager: LocationManager
    @Binding var play:Bool
    @Binding var shouldShow:Bool
    var body: some View{
        GeometryReader{
            reader in
            VStack(alignment: .center, spacing: 10){
                if locationManager.speed>0.1{
                    Text("Speed:\(locationManager.speed) m/s")
                }else if !play{
                    Text("Speed:\(0.0000) m/s")
                }else {
                    Text("Speed:\(0.0000) m/s")
                }
                HStack{
                    HStack{
                        Image(systemName: (play == false) ? "play":"pause")
                        Text((play == false) ? "Start":"Pause")
                    }
                    .padding()
                }
                .frame(width: 120, height: reader.size.height * 0.30)
                .foregroundColor(.white)
                .background((play == true) ? Color.red:Color.blue)
                //                .padding()
                .cornerRadius(10)
                .onTapGesture {
                    play.toggle()
                    NotificationCenter.default.post(Notification(name: Notification.Name.fileSaveNotification))
                }
                HStack{
                    HStack{
                        Text("Browse saved tracks")
                    }
                    .padding()
                }
                .frame(height: reader.size.height * 0.30)
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(10)
                .padding(.bottom, 10)
                .onTapGesture {
                    play = false
                    shouldShow = true
                    NotificationCenter.default.post(Notification(name: Notification.Name.fileSaveNotification))
                }
            }
            .frame(width:reader.size.width)
            .padding()
        }
    }
}
/*
 struct options_view_Previews: PreviewProvider {
 static var previews: some View {
 options_view()
 }
 }*/
