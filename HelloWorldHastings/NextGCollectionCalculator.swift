//
//  NextGCollectionCalculator.swift
//  HelloWorldHastings
//
//  Created by Yuejiang Zhang on 2015-11-01.
//  Copyright © 2015 Yuejiang Zhang. All rights reserved.
//

import Foundation

class NextGarbageCollectionCalculation{
    
    var originalDate: NSDate
    
    init(){
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss ZZZ"
        originalDate = formatter.dateFromString("2015/07/06 00:00:00 +0000")!
    }
    
    func getDateOnly(inputDate: NSDate) -> NSDate{
        return NSCalendar.currentCalendar().dateByAddingUnit(
            .Second,
            value: NSTimeZone.localTimeZone().secondsFromGMT,
            toDate: inputDate,
            options: NSCalendarOptions(rawValue: 0))!
    }
    
    func getDateString(inputDate: NSDate) -> String{
        let formatter = NSDateFormatter();
        formatter.dateFormat = "yyyy-MM-dd";
        return formatter.stringFromDate(inputDate);
    }

    func getNextCollectionDate(var fromDate: NSDate) -> GCInfo{
        let calendar: NSCalendar = NSCalendar.currentCalendar()

        fromDate = getDateOnly(fromDate)
        
        let flags = NSCalendarUnit.Day
        var components = calendar.components(flags, fromDate: originalDate, toDate: fromDate, options: [])
        
        var extraDays = components.day % 7
        if(extraDays == 0){
            extraDays = 7
        }
        
        let nextCDate = NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: 7 - extraDays,
            toDate: fromDate,
            options: NSCalendarOptions(rawValue: 0))

        components = calendar.components(flags, fromDate: nextCDate!, toDate: originalDate, options: [])
        let isThisOddWeek = components.day / 7 % 2 == 0
        
        return GCInfo(nextCollectionDate: nextCDate!, nextCollectionDateDesc: getDateString(nextCDate!), isOddWeek: isThisOddWeek, binColor: (isThisOddWeek == true ? "Black" : "Blue"))
    }
}

struct GCInfo {
    var nextCollectionDate : NSDate
    var nextCollectionDateDesc: String
    var isOddWeek : Bool
    var binColor: String
}