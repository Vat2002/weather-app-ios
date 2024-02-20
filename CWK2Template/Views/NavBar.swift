//
//  NavBar.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct NavBar: View {
    var body: some View {
        TabView{
            WeatherNowView()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            WeatherForecastView()
                .tabItem {
                    Label("Forecast", systemImage: "calendar.circle")
                }
            TouristPlacesMapView()
                .tabItem {
                    Label("Map", systemImage: "mappin.circle")
                }
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
