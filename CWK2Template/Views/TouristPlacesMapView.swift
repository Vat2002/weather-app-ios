//
//  TouristPlacesMapView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

struct TouristPlacesMapView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State var locations: [Location] = []
    @State private var showingAlert = false // Add this state variable
//    @State var  mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5216871, longitude: -0.1391574), latitudinalMeters: 600, longitudinalMeters: 600)
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 5) {
                        if weatherMapViewModel.coordinates != nil {
                            VStack(spacing: 10){
                                Map{
                                    ForEach(locations.filter { $0.cityName == weatherMapViewModel.city }) { location in
                                        Marker(location.name, coordinate: location.coordinates)
                                    }
                                }
                                .frame(height: UIScreen.main.bounds.height * 0.6)
                                .cornerRadius(20)
                                .padding()
                            }
                        }
                        
                        if locations.filter({ $0.cityName == weatherMapViewModel.city }).isEmpty {
                            Button(action: {
                                showingAlert = true
                            }) {
                                Text("Tourist attractions for city are not available.")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Tourist Attractions Not Available"), message: Text("Tourist attractions for \(weatherMapViewModel.city) are not available."), dismissButton: .default(Text("OK")))
                            }
                        }else{
                            Text("Tourist Attractions in \(weatherMapViewModel.city)")
                                .font(.custom("Arial", size: 20))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                            
                            VStack{
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                    ForEach(locations.filter { $0.cityName == weatherMapViewModel.city }) { location in
                                        VStack {
                                            Image(String(location.imageNames.first ?? ""))
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(20)
                                            Text("\(String(location.name))")
                                                .font(.title3)
                                                .bold()
                                        }
                                        .padding()
                                        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                    }
                                }
                            }
                            .padding()
                            .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                            .background(.white)
                            .cornerRadius(20)
                        }
                        
                    }.padding()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(.dark)
        }
        .onAppear {
            // process the loading of tourist places
            locations = weatherMapViewModel.loadLocationsFromJSONFile() ?? []
        }
    }
}

struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView()
    }
}
