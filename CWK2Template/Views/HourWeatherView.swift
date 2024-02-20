//
//  HourWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct HourWeatherView: View {
//    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    var current: Current
    var timeZone : String
    
    var body: some View {
        let formattedDate = DateFormatterUtils.formattedDateWithDay(from: TimeInterval(current.dt),timezoneIdentifier: timeZone)
        
        VStack{
            VStack{
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(current.weather[0].icon)@2x.png"))
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .shadow(color: .gray, radius: 10, x: 0, y: 0)
            }
            
            Text("\(formattedDate)")
            if !current.weather.isEmpty{
                let temp = (current.temp)
                Text("\(temp.roundDouble())ºC")
                    .font(.title2)
                    .bold()
            } else {
                Text("N/A")
            }
            Text(String(current.weather.first?.weatherDescription.rawValue.capitalized ?? "- -"))
        }
        .padding()
        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .background(.white)
        .cornerRadius(20)
    }
}
