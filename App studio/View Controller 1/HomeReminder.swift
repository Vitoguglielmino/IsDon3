//
//  HomeReminder.swift
//  Il mio prototipo
//
//  Created by Vito Guglielmino on 03/01/22.
//

import Foundation
import UIKit
import EventKit

class HomeReminderData: NSObject {
    
    enum Filter: Int {
        case today
        case week
        case all
        
        func shouldInclude(date: Date) -> Bool {
            let isInToday = Locale.current.calendar.isDateInToday(date)
            let isInWeek = Locale.current.calendar.isDate(date, inSameDayAs: date + 7)
            switch self {
            case .today:
                return isInToday
            case .week:
                return isInWeek
            case .all:
                return true 
            }
        }
    }
    
    
}
