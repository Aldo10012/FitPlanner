//
//  Date-ext.swift
//  FitPlanner
//
//  Created by Alberto Dominguez on 1/7/22.
//

import UIKit

extension Date {

  static func today() -> Date {
      return Date()
  }

  func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.next,
               weekday,
               considerToday: considerToday)
  }

  func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.previous,
               weekday,
               considerToday: considerToday)
  }

  func get(_ direction: SearchDirection,
           _ weekDay: Weekday,
           considerToday consider: Bool = false) -> Date {

    let dayName = weekDay.rawValue

    let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

    assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

    let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1

    let calendar = Calendar(identifier: .gregorian)

    if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
      return self
    }

    var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
    nextDateComponent.weekday = searchWeekdayIndex

    let date = calendar.nextDate(after: self,
                                 matching: nextDateComponent,
                                 matchingPolicy: .nextTime,
                                 direction: direction.calendarSearchDirection)

    return date!
  }

}

// MARK: Helper methods
enum Weekday: String {
  case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

extension Date {
  func getWeekDaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    return calendar.weekdaySymbols
  }

  enum SearchDirection {
    case next
    case previous

    var calendarSearchDirection: Calendar.SearchDirection {
      switch self {
      case .next:
        return .forward
      case .previous:
        return .backward
      }
    }
  }
}

func getDateAsString(_ date: Date) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "EEE"
  let dateAsString = dateFormatter.string(from: date)

  return dateAsString
}

func getDateAsStringLong(_ date: Date) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "EEEE"
  let dateAsString = dateFormatter.string(from: date)

  return dateAsString
}

func getMonthAndDateAsString(_ date: Date) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "MMMM dd"
  let dateAsString = dateFormatter.string(from: date)

  return dateAsString
}

extension Date {
    func skip(numOfDays num: Int)-> Date {
        return Calendar.current.date(byAdding: .day, value: num, to: Date.today())!
    }
}

var dateOfNextWorkout: Date = Date()
