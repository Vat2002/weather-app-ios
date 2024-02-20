//
//  WeatherNowView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct WeatherNowView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State private var isLoading = false
    @State private var temporaryCity = ""
    @State private var showingAlert = false
    
    var body: some View {
        
        let data = weatherMapViewModel.weatherDataModel
        let feeling = data?.current.weather[0].weatherDescription.rawValue.capitalized
        let strFeeling = String(feeling ?? "")
        
        ZStack{
            VStack{
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        VStack {
                            TextField("Search City", text: $temporaryCity)
                                .padding(.horizontal, 20) // Add horizontal padding for better text spacing
                                .padding(.vertical, 15)   // Adjust vertical padding for a more balanced look
                                .font(.system(size: 16, weight: .medium, design: .rounded)) // Use a rounded font for a softer appearance
                                .foregroundColor(.white)
                                .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                                .cornerRadius(20) // Increase corner radius for a more rounded shape
                                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.15), radius: 5, x: 0, y: 5) // Add a subtle shadow for depth
                                .onSubmit {
                                    // Check if the entered city contains only numbers if true shows alert
                                    if temporaryCity.allSatisfy(\.isNumber){
                                        showingAlert = true
                                    }else{
                                        weatherMapViewModel.city = temporaryCity // Set the city property in the WeatherMapViewModel
                                        Task {
                                            do {
                                                try await weatherMapViewModel.getCoordinatesForCity(cityName: "\(temporaryCity)") // Get coordinates for the entered city
                                                // Load weather data on the obtained coordinates or default values
                                                _ = try await weatherMapViewModel.loadData(lat: weatherMapViewModel.coordinates?.latitude ?? Constants.defaultLatitude, lon: weatherMapViewModel.coordinates?.longitude ?? Constants.defaultLongitude)
                                                print(">>>>> Current Location<<<<<")
                                                print("\(String(describing: weatherMapViewModel.weatherDataModel?.current))")
                                            } catch {
                                                print("Error: \(error)")
                                                isLoading = false
                                            }
                                        }
                                    }
                                }
                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text("Invalid Input!"), message: Text("Please enter a valid city name, not a number."), dismissButton: .default(Text("OK")))
                                }
                        }.padding(.top,10)
                        
                        VStack{
                            Text("\(weatherMapViewModel.city)")
                                .font(.custom("Arial", size: 26))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            if let unixTime = weatherMapViewModel.weatherDataModel?.current.dt, let currentTimeZone = weatherMapViewModel.weatherDataModel?.timezone{
                                let currentTime = DateFormatterUtils.getLocalTime(from: TimeInterval(unixTime), timezoneIdentifier: currentTimeZone, onlyDate: false)
                                Text(currentTime)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                            }
                            
                            VStack{
                                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(data?.current.weather[0].icon ?? "rain")@2x.png"))
                                    .scaledToFit()
                                    .frame(width: 150, height: 200)
                                    .shadow(color: .gray, radius: 10, x: 0, y: 0)
                            }
                            
                            Text("\(strFeeling)")
                                .font(.custom("Arial", size: 22))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                            
                        }.padding()
                    }
                    .padding()
                    .frame(height: 400)
                    .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                    .background(.white)
                    .cornerRadius(20)
                    Spacer()
                    
                    VStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Weather")
                                .bold()
                                .padding(.bottom)
                            
                            HStack {
                                WeatherInfo(logo: "thermometer", name: "Temp", value: ((data?.current.temp.roundDouble() ?? "N/A") + ("ºC")))
                                Spacer()
                                WeatherInfo(logo: "gauge.with.dots.needle.50percent", name: "Pressure", value: ((data?.current.pressure.roundToIntString() ?? "N/A") + ("hPa ")))
                            }
                            
                            HStack {
                                WeatherInfo(logo: "wind", name: "Wind Speed", value: ((data?.current.windSpeed.roundDouble() ?? "N/A") + ("mph")))
                                Spacer()
                                WeatherInfo(logo: "humidity", name: "Humdity", value: ((data?.current.humidity.roundToIntString() ?? "N/A") + ("%         ")))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom, 20)
                        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                        .background(.white)
                        .cornerRadius(20)
                    }
                }
            }.padding()
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
    
}

struct WeatherNowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherNowView()
    }
}
