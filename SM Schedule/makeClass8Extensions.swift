//
//  makeClass8Extensions.swift
//  SM Schedule
//
//  Created by Luc Cote on 8/30/16.
//  Copyright © 2016 EduApp. All rights reserved.
//

import UIKit

extension makeClass8 {
    
    func getDay()->Int{
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let myComponents = myCalendar?.components(.Weekday, fromDate: date)
        let weekDay = myComponents?.weekday
        return weekDay!
    }
    
    func getHour()->Int{
        let components = calender.components([.Hour, .Minute], fromDate: date)
        let hour = components.hour
        return hour
    }
    
    func getMinutes()->Int{
        let components = calender.components([.Hour, .Minute], fromDate: date)
        let minute = components.minute
        return minute
    }
    
    func getNextClass(){
        print("called method")
        let day = getDay()
        let hour = getHour()
        let minute = getMinutes()
        ViewController().nextClass.text = "classy"
        if day == 1 {
            vco?.getClass1()
            vco?.getLocation1()
            vco?.classStartTime.text = "Monday 8:30"
            view.backgroundColor = UIColor.greenColor()
        }
        else if day == 2{
            if hour < 9{
                vco?.getClass1()
                vco?.getLocation1()
                vco?.classStartTime.text = "8:30"
                view.backgroundColor = UIColor.greenColor()
            }else if (hour >= 9 && hour < 10) || (hour == 10 && minute < 15){
                vco?.getClass2()
                vco?.getLocation2()
                vco?.classStartTime.text = "9:50"
                view.backgroundColor = UIColor.purpleColor()
            }else if hour == 10 && minute >= 15 && minute < 45{
                vco?.nextClass.text = "X-Block"
                vco?.nextLocation.text = "Center"
                vco?.classStartTime.text = "10:35"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour >= 10 && hour < 12{
                if minute >= 45 || hour > 10 {
                    vco?.getClass3()
                    vco?.getLocation3()
                    vco?.classStartTime.text = "10:55"
                    view.backgroundColor = UIColor.redColor()
                }
                
            }else if hour == 12 && minute < 35 {
                vco?.nextClass.text = "Seated Lunch"
                vco?.nextLocation.text = "Dining Hall"
                vco?.classStartTime.text = "12:25"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour == 12 && minute >= 35 || hour == 1 && minute < 15{
                vco?.nextClass.text = "Co-Curricular"
                vco?.nextLocation.text = "PFAC"
                vco?.classStartTime.text = "1:00"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if (hour > 13 && hour < 15) || (hour == 13 && minute >= 15) {
                vco?.getClass4()
                vco?.getLocation4()
                vco?.classStartTime.text = "1:45"
                view.backgroundColor = UIColor.orangeColor()
            }else if hour >= 15 {
                vco?.getClass5()
                vco?.getLocation5()
                vco?.classStartTime.text = "Tuesday 8:30"
                view.backgroundColor = UIColor.blueColor()
            }
        }
        else if day == 3{
            if hour < 9{
                vco?.getClass5()
                vco?.getLocation5()
                vco?.classStartTime.text = "8:30"
                view.backgroundColor = UIColor.blueColor()
            }else if (hour >= 9 && hour < 10) || (hour == 10 && minute < 15){
                vco?.getClass1()
                vco?.getLocation1()
                vco?.classStartTime.text = "9:50"
                view.backgroundColor = UIColor.greenColor()
            }else if hour == 10 && minute >= 15 && minute < 45{
                vco?.nextClass.text = "X-Block"
                vco?.nextLocation.text = "Center"
                vco?.classStartTime.text = "10:35"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour >= 10 && hour < 12{
                if minute >= 45 || hour > 10 {
                    vco?.getClass2()
                    vco?.getLocation2()
                    vco?.classStartTime.text = "10:55"
                    view.backgroundColor = UIColor.purpleColor()
                }
                
            }else if hour == 12 && minute < 35 {
                vco?.nextClass.text = "Lunch"
                vco?.nextLocation.text = "Dining Hall"
                vco?.classStartTime.text = "12:25"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour == 12 && minute >= 35 || hour == 13 && minute < 15{
                vco?.getClass6()
                vco?.getLocation6()
                vco?.classStartTime.text = "12:55"
                view.backgroundColor = UIColor.brownColor()
            }else if (hour > 13 && hour < 15) || (hour == 13 && minute >= 15) {
                vco?.getClass7()
                vco?.getLocation7()
                vco?.classStartTime.text = "1:40"
                view.backgroundColor = UIColor.yellowColor()
            }else if hour >= 15 {
                vco?.getClass4()
                vco?.getLocation4()
                vco?.classStartTime.text = "Wednesday 8:00"
                view.backgroundColor = UIColor.orangeColor()
            }
        }
            
        else if day == 4{
            if (hour < 8) || (hour == 8 && minute < 45){
                vco?.getClass4()
                vco?.getLocation4()
                vco?.classStartTime.text = "8:00"
                view.backgroundColor = UIColor.orangeColor()
            }else if (hour == 9 && minute < 35) || (hour == 8 && minute >= 45){
                vco?.getClass3()
                vco?.getLocation3()
                vco?.classStartTime.text = "9:20"
                view.backgroundColor = UIColor.redColor()
            }else if (hour == 9 && minute >= 35) || (hour == 10 && minute < 15){
                vco?.nextClass.text = "School Meeting"
                vco?.nextLocation.text = "Center"
                vco?.classStartTime.text = "10:05"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if (hour == 10 && minute >= 15) {
                vco?.getClass6()
                vco?.getLocation6()
                vco?.classStartTime.text = "10:30"
                view.backgroundColor = UIColor.brownColor()
            }else if (hour == 11) || (hour == 12 && minute < 5){
                vco?.nextClass.text = "Lunch"
                vco?.nextLocation.text = "Dining Hall"
                vco?.classStartTime.text = "11:50"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour == 12 && minute >= 5 {
                vco?.getClass5()
                vco?.getLocation5()
                vco?.classStartTime.text = "12:20"
                view.backgroundColor = UIColor.blueColor()
            }else if hour >= 13 {
                vco?.getClass7()
                vco?.getLocation7()
                vco?.classStartTime.text = "Thursday 8:30"
                view.backgroundColor = UIColor.yellowColor()
            }
        }
        else if day == 5{
            if hour < 9{
                vco?.getClass7()
                vco?.getLocation7()
                vco?.classStartTime.text = "8:30"
                view.backgroundColor = UIColor.yellowColor()
            }else if (hour >= 9 && hour < 10) || (hour == 10 && minute < 15){
                vco?.getClass4()
                vco?.getLocation4()
                vco?.classStartTime.text = "9:50"
                view.backgroundColor = UIColor.orangeColor()
            }else if hour == 10 && minute >= 15 && minute < 45{
                vco?.nextClass.text = "X-Block"
                vco?.nextLocation.text = "Center"
                vco?.classStartTime.text = "10:35"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour >= 10 && hour < 12{
                if minute >= 45 || hour > 10 {
                    vco?.getClass2()
                    vco?.getLocation2()
                    vco?.classStartTime.text = "10:55"
                    view.backgroundColor = UIColor.purpleColor()
                }
                
            }else if hour == 12 && minute < 35 {
                vco?.nextClass.text = "Seated Lunch"
                vco?.nextLocation.text = "Dining Hall"
                vco?.classStartTime.text = "12:25"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour == 12 && minute >= 35 || hour == 13 && minute < 15{
                vco?.nextClass.text = "Co-Curricular"
                vco?.nextLocation.text = "PFAC"
                vco?.classStartTime.text = "1:00"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if (hour > 13 && hour < 15) || (hour == 13 && minute >= 15) {
                vco?.getClass1()
                vco?.getLocation1()
                vco?.classStartTime.text = "1:45"
                view.backgroundColor = UIColor.greenColor()
            }else if hour >= 15 {
                vco?.getClass3()
                vco?.getLocation3()
                vco?.classStartTime.text = "Friday 8:30"
                view.backgroundColor = UIColor.redColor()
            }
        }
        else if day == 6{
            if hour < 9{
                vco?.getClass3()
                vco?.getLocation3()
                vco?.classStartTime.text = "8:30"
                view.backgroundColor = UIColor.redColor()
            }else if (hour >= 9 && hour < 10) || (hour == 10 && minute < 15){
                vco?.getClass7()
                vco?.getLocation7()
                vco?.classStartTime.text = "9:50"
                view.backgroundColor = UIColor.yellowColor()
            }else if hour == 10 && minute >= 15 && minute < 45{
                vco?.nextClass.text = "X-Block"
                vco?.nextLocation.text = "Center"
                vco?.classStartTime.text = "10:35"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour >= 10 && hour < 12{
                if minute >= 45 || hour > 10 {
                    vco?.getClass5()
                    vco?.getLocation5()
                    vco?.classStartTime.text = "10:55"
                    view.backgroundColor = UIColor.blueColor()
                }
                
            }else if hour == 12 && minute < 35 {
                vco?.nextClass.text = "Lunch"
                vco?.nextLocation.text = "Dining Hall"
                vco?.classStartTime.text = "12:25"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour == 12 && minute >= 35 || hour == 13 && minute < 15{
                vco?.nextClass.text = "Co-Curricular"
                vco?.nextLocation.text = "PFAC"
                vco?.classStartTime.text = "12:55"
                view.backgroundColor = UIColor.brownColor()
            }else if (hour > 13 && hour < 15) || (hour == 13 && minute >= 15) {
                vco?.getClass6()
                vco?.getLocation6()
                vco?.classStartTime.text = "1:40"
                view.backgroundColor = UIColor.yellowColor()
            }else if hour >= 15 {
                vco?.getClass8()
                vco?.getLocation8()
                vco?.classStartTime.text = "Saturday 9:00"
                view.backgroundColor = UIColor.lightGrayColor()
            }
        }else {
            vco?.getClass8()
            vco?.getLocation8()
            vco?.classStartTime.text = "9:00"
            view.backgroundColor = UIColor.lightGrayColor()
        }
        
        
        
    }
    
}