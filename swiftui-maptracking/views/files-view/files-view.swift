//
//  files-view.swift
//  assign4
//
//  Created by Adil Anwer on 29/04/2021.
//

import SwiftUI
import CoreLocation

struct FilesView:View {
    @Binding var show:Bool
    var data:[URL]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var pins:[MapPin] = []
    @State var navigatoToTrackView = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        NavigationView{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(data, id: \.self) { item in
                        VStack(alignment: .center, spacing: 1.0){
                            Image(systemName: "doc")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.black)
                                .frame(width: 30, height: 30, alignment: .center)
                                .padding(4)
                            Text("\(item.fileModificationDate(url: item)!.completeDateTime)")
                                .font(.system(size: 11.0))
                                .padding(4)
                            NavigationLink(
                                destination: TracksMap(trackPoints: pins),
                                isActive: $navigatoToTrackView,
                                label: {
                                    Text("")
                                })
                        }
                        .frame(alignment: .center)
                        .onTapGesture {
                            let track = DocumentDirectoryFilesFunctions.read(fromDocumentsWithFileName: item.path)
                            var count = 0
                            if let trackPoints = track{
                                while(count<trackPoints.count){
                                    let point = trackPoints[count]
                                    pins.append(MapPin(coordinate: CLLocationCoordinate2DMake(point.latitude, point.longitude)))
                                    count = +1
                                }
                                navigatoToTrackView = true
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
//            .frame(maxHeight: 300)
            .navigationBarTitle(Text("Saved tracks"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {show=false}, label: {Text("Cancel")}))
            .onAppear(){
               
            }
        }
    }
}
/*
 struct files_view_Previews: PreviewProvider {
 static var previews: some View {
 files_view()
 }
 }*/
