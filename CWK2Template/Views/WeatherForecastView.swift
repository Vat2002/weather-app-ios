//
//  WeatherForcastView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct WeatherForecastView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    
    var body: some View {
       
        let data = weatherMapViewModel.weatherDataModel?.daily
        let dataFeeling = weatherMapViewModel.weatherDataModel
        let timezone = weatherMapViewModel.weatherDataModel?.timezone ?? ""
        let feeling = dataFeeling?.current.weather[0].weatherDescription.rawValue.capitalized
        let strFeeling = String(feeling ?? "")
                
            ZStack{
                VStack{
                    ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            //top widget view
                            VStack{
                                HStack(spacing: 20){
                                    VStack(alignment: .leading){
                                        Text("\(weatherMapViewModel.city)")
                                            .font(.title2)
                                            .bold()
                                        if let unixTime = weatherMapViewModel.weatherDataModel?.current.dt, let currentTimeZone = weatherMapViewModel.weatherDataModel?.timezone{
                                            let currentTime = DateFormatterUtils.getLocalTime(from: TimeInterval(unixTime), timezoneIdentifier: currentTimeZone, onlyDate: true)
                                            Text(currentTime)
                                                .fontWeight(.bold)
                                                .multilineTextAlignment(.center)
                                        }
                                        if let forecast = weatherMapViewModel.weatherDataModel?.current.temp {
                                            Text("\(forecast.roundDouble())ºC")
                                                .font(.title2)
                                                .bold()
                                        } else {
                                            Text("N/A")
                                        }
                                        
                                        Text("\(strFeeling)")
                                        if let feelsLikeT = data?.first?.feelsLike.day {
                                            Text("Feels like:\(feelsLikeT.roundDouble())ºC")
                                                .lineLimit(1)
                                        } else {
                                            Text("N/A")
                                        }
                                    }
                                    Spacer()
                                    VStack{
                                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(dataFeeling?.current.weather[0].icon ?? "rain")@2x.png"))
                                            .scaledToFit()
                                            .frame(width: 100, height: 150)
                                            .shadow(color: .gray, radius: 10, x: 0, y: 0)
                                    }
                                }.padding()
                            }
                            .padding()
                            .frame(height: 220)
                            .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                            .background(.white)
                            .cornerRadius(20)
                            
                            
                            if let hourlyData = weatherMapViewModel.weatherDataModel?.hourly {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(hourlyData) { hour in
                                            HourWeatherView(current: hour, timeZone: timezone)
                                        }
                                    }
                                }
                                .frame(height: 180)
                            }
                            
                            //next days scroll view
                            VStack{
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack(alignment: .leading){
                                        ForEach(weatherMapViewModel.weatherDataModel?.daily ?? []){  day in
                                            DailyWeatherView(day: day)
                                        }
                                    }
                                }
                            }
                            
                        }
                        .padding()
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(.dark)
        
    }
}

struct WeatherForcastView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherForecastView()
    }
}
