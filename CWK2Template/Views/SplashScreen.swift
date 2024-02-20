//
//  SplashScreen.swift
//  CWK2Template
//
//  Created by Vat on 2024-01-01.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack{
            //Gradient Background
            LinearGradient(gradient: Gradient(colors: [Color.mint, Color.mint ,Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack{
                // App Logo
                Image("rain")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 200)
                    .accessibilityLabel("Weather App Logo")
                Spacer()
                Text("Weatheriz")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
     
                Text("Say hello to Weatheriz \n the ultimate weather foresight app.\n Now plan your day with confidence.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                NavigationLink {
                    WeatherNowView()
                } label: {
                    HStack {
                        Text("Get Started")
                        Image(systemName: "chevron.right")
                    }
                }
                .frame(width: 200,height: 50)
                .background(.yellow)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.top,150)
            }
            .padding()
        }
    }
}

#Preview {
    SplashScreen()
}
