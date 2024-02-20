//
//  DailyWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct DailyWeatherView: View {
    var day: Daily
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    
    var body: some View {
        
        let formattedDate = DateFormatterUtils.formattedDateWithWeekdayAndDay(from: TimeInterval(day.dt))
        let feeling = String(day.weather[0].weatherDescription.rawValue.capitalized)
        
        VStack{
            HStack{
                VStack(alignment:.leading){
                    Text("\(formattedDate)")
                    Text("\(feeling)")
                }
                Spacer()
                VStack{
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(day.weather[0].icon)@2x.png"))
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .shadow(color: .gray, radius: 10, x: 0, y: 0)
                }
                Spacer()
                VStack{
                    let maxTemp = (day.temp.max)
                    let minTemp = (day.temp.min)
                    Text("\(maxTemp.roundDouble()) ºC")
                    Text("\(minTemp.roundDouble()) ºC")
                }
            }
        }
        .padding()
        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .background(.white)
        .cornerRadius(20)
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var day = WeatherMapViewModel().weatherDataModel!.daily
    static var previews: some View {
        DailyWeatherView(day: day[0])
    }
}
