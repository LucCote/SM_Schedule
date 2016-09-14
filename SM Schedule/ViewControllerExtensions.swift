//
//  ViewControllerExtensions.swift
//  SM Schedule
//
//  Created by Luc Cote on 8/26/16.
//  Copyright © 2016 EduApp. All rights reserved.
//

import UIKit

extension ViewController {
    
    func refresh() {
        nextClassLabel.text = "Refreshing"
        getNextClass()
        nextClassLabel.text = "Next Class:"
    }
    
    func tellUserRefresh() {
        nextClassLabel.text = "Press and Hold"
        nextClass.text = "To Set Classes"
        nextLocation.text = ""
        classStartTime.text = ""
    }
    
    func getNextClass(){
        print("called method")
        let day = getDay()
        let hour = getHour()
        let minute = getMinutes()
        if day == 1 {
            getClass1()
            getLocation1()
            classStartTime.text = "Monday 8:30"
            view.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 65/255, alpha: 1)
        }
        else if day == 2{
            if (hour == 8 && minute < 50) || (hour < 8) {
                getClass1()
                getLocation1()
                classStartTime.text = "8:30"
                view.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 65/255, alpha: 1)
            }else if (hour == 8 && minute >= 50) || (hour == 9) || (hour == 10 && minute < 10){
                getClass2()
                getLocation2()
                classStartTime.text = "9:55"
                view.backgroundColor = UIColor(red: 212/255, green: 1/255, blue: 232/255, alpha: 1)
            }else if hour == 10 && minute >= 10 && minute < 45{
                nextClass.text = "X-Block"
                nextLocation.text = "Center"
                classStartTime.text = "10:35"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if (hour == 10 && minute >= 45) || (hour == 11 && minute < 10){
                getClass3()
                getLocation3()
                classStartTime.text = "11:00"
                view.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
                
            }else if (hour == 12 && minute < 40) || (hour == 11 && minute >= 10){
                nextClass.text = "Seated Lunch"
                nextLocation.text = "Dining Hall"
                classStartTime.text = "12:25"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour == 12 && minute >= 40 || hour == 13 && minute < 20{
                nextClass.text = "Co-Curricular"
                nextLocation.text = "PFAC"
                classStartTime.text = "1:00"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if (hour > 13 && hour < 15) || (hour == 13 && minute >= 20) {
                getClass4()
                getLocation4()
                classStartTime.text = "1:45"
                view.backgroundColor = UIColor(red: 232/255, green: 184/255, blue: 12/255, alpha: 1)
            }else if hour >= 15 {
                nextClass.text = "Chapel"
                nextLocation.text = "Belmont Chapel"
                classStartTime.text = "Tuesday 8:00"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }
        }
        else if day == 3{
            if (hour < 8) || (hour == 8 && minute < 10){
                nextClass.text = "Chapel"
                nextLocation.text = "Belmont Chapel"
                classStartTime.text = "8:00"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }
            if hour == 8 && minute < 50 && minute >= 10{
                getClass5()
                getLocation5()
                classStartTime.text = "8:30"
                view.backgroundColor = UIColor(red: 7/255, green: 24/255, blue: 232/255, alpha: 1)
            }else if (hour == 8 && minute >= 50) || (hour == 10 && minute < 10) || (hour == 9){
                getClass1()
                getLocation1()
                classStartTime.text = "9:55"
                view.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 65/255, alpha: 1)
            }else if hour == 10 && minute >= 10 && minute < 45{
                nextClass.text = "X-Block"
                nextLocation.text = "Center"
                classStartTime.text = "10:35"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if (hour == 10 && minute >= 45) || (hour == 11 && minute < 15) {
                getClass2()
                getLocation2()
                classStartTime.text = "11:00"
                view.backgroundColor = UIColor(red: 212/255, green: 1/255, blue: 232/255, alpha: 1)
            }else if (hour == 11 && minute >= 15) || (hour == 12 && minute < 40) {
                nextClass.text = "Lunch"
                nextLocation.text = "Dining Hall"
                classStartTime.text = "11:30"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if (hour == 12 && minute >= 40) || (hour == 13 && minute < 15) {
                getClass6()
                getLocation6()
                classStartTime.text = "12:55"
                view.backgroundColor = UIColor(red: 232/255, green: 164/255, blue: 8/255, alpha: 1)
            }else if (hour > 13 && hour < 15) || (hour == 13 && minute >= 15) {
                getClass7()
                getLocation7()
                classStartTime.text = "1:45"
                view.backgroundColor = UIColor(red: 255/255, green: 234/255, blue: 8/255, alpha: 1)
            }else if hour >= 15 {
                getClass4()
                getLocation4()
                classStartTime.text = "Wednesday 8:00"
                view.backgroundColor = UIColor(red: 232/255, green: 184/255, blue: 12/255, alpha: 1)
            }
        }
        
        else if day == 4{
            if (hour < 8) || (hour == 8 && minute < 20){
                getClass4()
                getLocation4()
                classStartTime.text = "8:00"
                view.backgroundColor = UIColor(red: 232/255, green: 184/255, blue: 12/255, alpha: 1)
            }else if (hour == 9 && minute < 40) || (hour == 8 && minute >= 20){
                getClass3()
                getLocation3()
                classStartTime.text = "9:25"
                view.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
            }else if (hour == 9 && minute >= 40) || (hour == 10 && minute < 15){
                nextClass.text = "School Meeting"
                nextLocation.text = "Center"
                classStartTime.text = "10:05"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if (hour == 10 && minute >= 15) {
                getClass6()
                getLocation6()
                classStartTime.text = "10:40"
                view.backgroundColor = UIColor(red: 232/255, green: 164/255, blue: 8/255, alpha: 1)
            }else if (hour == 11) || (hour == 12 && minute < 5){
                nextClass.text = "Lunch"
                nextLocation.text = "Dining Hall"
                classStartTime.text = "11:30"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour == 12 && minute >= 5 {
                getClass5()
                getLocation5()
                classStartTime.text = "12:30"
                view.backgroundColor = UIColor(red: 7/255, green: 24/255, blue: 232/255, alpha: 1)
            }else if hour >= 13 {
                getClass7()
                getLocation7()
                classStartTime.text = "Thursday 8:30"
                view.backgroundColor = UIColor(red: 255/255, green: 234/255, blue: 8/255, alpha: 1)
            }
        }
        else if day == 5{
            if hour < 8 || hour == 8 && minute < 50{
                getClass7()
                getLocation7()
                classStartTime.text = "8:30"
                view.backgroundColor = UIColor(red: 255/255, green: 234/255, blue: 8/255, alpha: 1)
            }else if (hour == 9) || (hour == 10 && minute < 10) || (hour == 8 && minute >= 50) {
                getClass4()
                getLocation4()
                classStartTime.text = "9:55"
                view.backgroundColor = UIColor(red: 232/255, green: 184/255, blue: 12/255, alpha: 1)
            }else if hour == 10 && minute >= 10 && minute < 45{
                nextClass.text = "X-Block"
                nextLocation.text = "Center"
                classStartTime.text = "10:35"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour == 11 && minute < 15 || hour == 10 && minute >= 45 {
                getClass2()
                getLocation2()
                classStartTime.text = "11:00"
                view.backgroundColor = UIColor(red: 212/255, green: 1/255, blue: 232/255, alpha: 1)
            }else if (hour == 12 && minute < 40) || (hour == 11 && minute >= 15) {
                nextClass.text = "Seated Lunch"
                nextLocation.text = "Dining Hall"
                classStartTime.text = "12:25"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour == 12 && minute >= 40 || hour == 13 && minute < 20 {
                nextClass.text = "Co-Curricular"
                nextLocation.text = "PFAC"
                classStartTime.text = "1:00"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if (hour == 14) || (hour == 13 && minute >= 20) {
                getClass1()
                getLocation1()
                classStartTime.text = "1:45"
                view.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 65/255, alpha: 1)
            }else if hour >= 15 {
                nextClass.text = "Chapel"
                nextLocation.text = "Belmont Chapel"
                classStartTime.text = "Tuesday 8:00"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)            }
        }
        else if day == 6{
            if (hour < 8) || (hour == 8 && minute < 10) {
                nextClass.text = "Chapel"
                nextLocation.text = "Belmont Chapel"
                classStartTime.text = "8:00"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }
            if hour == 8 && minute >= 10 && minute < 50{
                getClass3()
                getLocation3()
                classStartTime.text = "8:30"
                view.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
            }else if (hour == 9) || (hour == 10 && minute < 10) || (hour == 8 && minute >= 50){
                getClass7()
                getLocation7()
                classStartTime.text = "9:55"
                view.backgroundColor = UIColor(red: 255/255, green: 234/255, blue: 8/255, alpha: 1)
            }else if hour == 10 && minute >= 10 && minute < 45{
                nextClass.text = "X-Block"
                nextLocation.text = "Center"
                classStartTime.text = "10:35"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if (hour == 10 && minute >= 45) || (hour == 11 && minute < 20) {
                getClass5()
                getLocation5()
                classStartTime.text = "11:00"
                view.backgroundColor = UIColor(red: 7/255, green: 24/255, blue: 232/255, alpha: 1)
            }else if hour == 12 && minute < 40 || hour == 11 && minute >= 20 {
                nextClass.text = "Lunch"
                nextLocation.text = "Dining Hall"
                classStartTime.text = "11:30"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if hour == 12 && minute >= 40 || hour == 13 && minute < 15{
                nextClass.text = "Co-Curricular"
                nextLocation.text = "PFAC"
                classStartTime.text = "12:55"
                view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
            }else if (hour == 14) || (hour == 13 && minute >= 15) {
                getClass6()
                getLocation6()
                classStartTime.text = "1:40"
                view.backgroundColor = UIColor(red: 232/255, green: 164/255, blue: 8/255, alpha: 1)
            }else if hour >= 15 {
                getClass8()
                getLocation8()
                classStartTime.text = "Saturday 9:00"
                view.backgroundColor = UIColor.lightGrayColor()
            }
        }else {
            getClass8()
            getLocation8()
            classStartTime.text = "9:00"
            view.backgroundColor = UIColor.lightGrayColor()
        }


        
    }
    
}
