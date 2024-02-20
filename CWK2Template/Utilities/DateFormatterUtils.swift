//
//  DateFormatterUtils.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import Foundation

class DateFormatterUtils {
    static let shared: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return dateFormatter
    }()

    static let shortDateFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()

    static let timeFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }()

    static let customFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()

    static func formattedDate(from timestamp: Int, format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

    static func formattedCurrentDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }

    static func formattedDateWithStyle(from timestamp: Int, style: DateFormatter.Style) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: date)
    }
    static func formattedDate12Hour(from timestamp: TimeInterval) -> String {
            let date = Date(timeIntervalSince1970: timestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: date)
        }
//    static func formattedDateWithDay(from timestamp: TimeInterval) -> String {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "h a E" // Format for 12-hour time with AM/PM and abbreviated day of the week
//            let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
//            return dateString
//        }
    static func formattedDateWithDay(from timestamp: TimeInterval, timezoneIdentifier: String) -> String {
                let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(identifier: timezoneIdentifier)
                dateFormatter.dateFormat = "h a E" // Format for 12-hour time with AM/PM and abbreviated day of the week
                let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
                return dateString
            }
    static func formattedDateWithWeekdayAndDay(from timestamp: TimeInterval) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE dd"
            return dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
        }
    static func formattedDateTime(from timestamp: TimeInterval) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy 'at' ha"
            return dateFormatter.string(from: Date(timeIntervalSince1970: timestamp))
        }
    
    static func getLocalTime(from unixTime: TimeInterval, timezoneIdentifier: String, onlyDate: Bool) -> String {
            let date = Date(timeIntervalSince1970: unixTime)

            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(identifier: timezoneIdentifier) //setting the timezone of the DateFormatter to the provided timezoneIdentifier
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            if onlyDate {
                dateFormatter.dateFormat = "h:mm a"
            }else{
                dateFormatter.dateFormat = "dd/MM/yyyy"
            }
            
            // Convert the date to a string format and returns the value
            let localDate = dateFormatter.string(from: date)
            return localDate
    }
        
}
