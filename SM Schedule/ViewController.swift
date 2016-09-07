//
//  ViewController.swift
//  SM Schedule
//
//  Created by Luc Cote on 8/17/16.
//  Copyright © 2016 EduApp. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    let date = NSDate()
    let calender = NSCalendar.currentCalendar()
    var locations = [Int: String]()
    let url = NSURL (string: "https://www.google.com/maps/@42.309796,-71.5294772,57m/data=!3m1!1e3");

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(refresh)))
        view.userInteractionEnabled = true
        return view
    }()
    
    let nextClassLabel: UILabel = {
        let l = UILabel()
        l.text = "Next Class:"
        l.textColor = UIColor.blackColor()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = NSTextAlignment.Center
        l.font = UIFont.boldSystemFontOfSize(42)
        return l
    }()
    
    let nextClass: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor.blackColor()
        l.text = "nextClass"
        l.textAlignment = .Center
        l.font = l.font.fontWithSize(30)
        return l
    }()
    
    let nextLocation: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor.blackColor()
        l.text = "nextLocation"
        l.textAlignment = .Center
        l.font = UIFont.italicSystemFontOfSize(26)
        return l
    }()
    
    let classStartTime: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor.blackColor()
        l.text = "startTime"
        l.textAlignment = .Center
        l.font = l.font.fontWithSize(25)
        return l
    }()
    
    let viewSwitchContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return v
    }()
    
    lazy var homeView: UIButton = {
        let b = UIButton(type: .System)
        b.layer.cornerRadius = 33
        b.layer.masksToBounds = true
        b.backgroundColor = UIColor(red: 70/255, green: 130/255, blue: 180/255, alpha: 1)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "homeIcon"), forState: .Normal)
        b.tintColor = UIColor.darkGrayColor()
        b.addTarget(self, action: #selector(homeButtonPress), forControlEvents: .TouchUpInside)
        return b
    }()
    
    lazy var scheduleView: UIButton = {
        let b = UIButton(type: .System)
        b.layer.cornerRadius = 28
        b.layer.masksToBounds = true
        b.backgroundColor = UIColor(red: 70/255, green: 130/255, blue: 180/255, alpha: 1)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "scheduleIcon"), forState: .Normal)
        b.tintColor = UIColor.grayColor()
        b.addTarget(self, action: #selector(scheduleButtonPress), forControlEvents: .TouchUpInside)
        b.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(returnToOriginalScheduleImage)))
        b.userInteractionEnabled = true
        return b
    }()
    
    lazy var mapView: UIButton = {
        let b = UIButton(type: .System)
        b.layer.cornerRadius = 28
        b.layer.masksToBounds = true
        b.backgroundColor = UIColor(red: 70/255, green: 130/255, blue: 180/255, alpha: 1)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "mapIcon"), forState: .Normal)
        b.tintColor = UIColor.grayColor()
        b.addTarget(self, action: #selector(mapButtonPress), forControlEvents: .TouchUpInside)
        return b
    }()
    
    let scheduleViewContainer: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = UIImage(named: "schoolMap")
        return v
    }()
    
    let mapImage: UIImageView = {
    let v = UIImageView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.image = UIImage(named: "schoolMap")
    return v
    }()
    
    lazy var scheduleImage: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleImagePress)))
        i.userInteractionEnabled = true
        return i
    }()
    
    let mapViewContainer: UIWebView = {
        let v = UIWebView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var containerViewXConstraint: NSLayoutConstraint?
    var containerViewYConstraint: NSLayoutConstraint?
    var containerViewHConstraint: NSLayoutConstraint?
    var containerViewWConstraint: NSLayoutConstraint?
    
    var scheduleButtonWConstraint: NSLayoutConstraint?
    var scheduleButtonHConstraint: NSLayoutConstraint?
    
    var mapButtonWConstraint: NSLayoutConstraint?
    var mapButtonHConstraint: NSLayoutConstraint?
    
    var homeButtonWConstraint: NSLayoutConstraint?
    var homeButtonHConstraint: NSLayoutConstraint?
    
    var scheduleContainerViewXConstraint: NSLayoutConstraint?
    var scheduleContainerViewYConstraint: NSLayoutConstraint?
    var scheduleContainerViewHConstraint: NSLayoutConstraint?
    var scheduleContainerViewWConstraint: NSLayoutConstraint?
    
    var mapContainerViewXConstraint: NSLayoutConstraint?
    var mapContainerViewYConstraint: NSLayoutConstraint?
    var mapContainerViewHConstraint: NSLayoutConstraint?
    var mapContainerViewWConstraint: NSLayoutConstraint?
    
//    let secondClass: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.textColor = UIColor.whiteColor()
//        l.text = "secondClass"
//        return l
//    }()
//    
//    let thirdClass: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.textColor = UIColor.whiteColor()
//        l.text = "secondClass"
//        return l
//    }()
//    
//    let fourthClass: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.textColor = UIColor.whiteColor()
//        l.text = "secondClass"
//        return l
//    }()
//    
//    let fifthClass: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.textColor = UIColor.whiteColor()
//        l.text = "secondClass"
//        return l
//    }()
//    
//    let sixthClass: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.textColor = UIColor.whiteColor()
//        l.text = "secondClass"
//        return l
//    }()
//    
//    let seventhClass: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.textColor = UIColor.whiteColor()
//        l.text = "secondClass"
//        return l
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(handleLogout))
        checkIfUserLoggedIn()
        let image = UIImage(named: "edit_property")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: #selector(editClasses))
        
        view.addSubview(containerView)
        view.addSubview(viewSwitchContainerView)
        
        viewSwitchContainerView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        viewSwitchContainerView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        viewSwitchContainerView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        viewSwitchContainerView.heightAnchor.constraintEqualToConstant(70).active = true
        
        containerViewYConstraint = containerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
        containerViewYConstraint?.active = true
        containerViewXConstraint=containerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        containerViewXConstraint?.active = true
        containerViewWConstraint=containerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -12)
        containerViewWConstraint?.active = true
        containerViewHConstraint=containerView.heightAnchor.constraintEqualToConstant(327)
        containerViewHConstraint?.active = true
        
        containerView.addSubview(nextClass)
        containerView.addSubview(nextClassLabel)
        containerView.addSubview(nextLocation)
        containerView.addSubview(classStartTime)
        
        nextClassLabel.topAnchor.constraintEqualToAnchor(containerView.topAnchor, constant: 40).active = true
        nextClassLabel.centerXAnchor.constraintEqualToAnchor(containerView.centerXAnchor).active = true
        nextClassLabel.widthAnchor.constraintEqualToAnchor(containerView.widthAnchor).active = true
        nextClassLabel.heightAnchor.constraintEqualToConstant(50).active = true
        
        nextClass.topAnchor.constraintEqualToAnchor(nextClassLabel.bottomAnchor, constant: 15).active = true
        nextClass.centerXAnchor.constraintEqualToAnchor(containerView.centerXAnchor).active = true
        nextClass.widthAnchor.constraintEqualToAnchor(containerView.widthAnchor).active = true
        nextClass.heightAnchor.constraintEqualToConstant(50).active = true
        
        nextLocation.topAnchor.constraintEqualToAnchor(nextClass.bottomAnchor, constant: 11).active = true
        nextLocation.centerXAnchor.constraintEqualToAnchor(containerView.centerXAnchor).active = true
        nextLocation.widthAnchor.constraintEqualToAnchor(containerView.widthAnchor).active = true
        nextLocation.heightAnchor.constraintEqualToConstant(50).active = true
        
        classStartTime.topAnchor.constraintEqualToAnchor(nextLocation.bottomAnchor, constant: 11).active = true
        classStartTime.centerXAnchor.constraintEqualToAnchor(containerView.centerXAnchor).active = true
        classStartTime.widthAnchor.constraintEqualToAnchor(containerView.widthAnchor).active = true
        classStartTime.heightAnchor.constraintEqualToConstant(50).active = true
        
        viewSwitchContainerView.addSubview(homeView)
        viewSwitchContainerView.addSubview(scheduleView)
        viewSwitchContainerView.addSubview(mapView)
        
        homeView.centerXAnchor.constraintEqualToAnchor(viewSwitchContainerView.centerXAnchor).active = true
        homeView.centerYAnchor.constraintEqualToAnchor(viewSwitchContainerView.centerYAnchor).active = true
        homeButtonWConstraint = homeView.widthAnchor.constraintEqualToConstant(66)
        homeButtonWConstraint?.active = true
        homeButtonHConstraint = homeView.heightAnchor.constraintEqualToConstant(66)
        homeButtonHConstraint?.active = true
        
        scheduleView.centerYAnchor.constraintEqualToAnchor(viewSwitchContainerView.centerYAnchor).active = true
        scheduleView.leftAnchor.constraintEqualToAnchor(viewSwitchContainerView.leftAnchor, constant: 20).active = true
        scheduleButtonWConstraint = scheduleView.widthAnchor.constraintEqualToConstant(56)
        scheduleButtonWConstraint?.active = true
        scheduleButtonHConstraint = scheduleView.heightAnchor.constraintEqualToConstant(56)
        scheduleButtonHConstraint?.active = true
        
        mapView.centerYAnchor.constraintEqualToAnchor(viewSwitchContainerView.centerYAnchor).active = true
        mapView.rightAnchor.constraintEqualToAnchor(viewSwitchContainerView.rightAnchor, constant: -20).active = true
        mapButtonWConstraint = mapView.widthAnchor.constraintEqualToConstant(56)
        mapButtonWConstraint?.active = true
        mapButtonHConstraint = mapView.heightAnchor.constraintEqualToConstant(56)
        mapButtonHConstraint?.active = true
        
        setUpMapAndSchedule()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func checkIfUserLoggedIn(){
        print("check if logged in")
        if FIRAuth.auth()?.currentUser?.uid == nil {
            //user is not logged in
            performSelector(#selector(handleLogout), withObject: nil, afterDelay: 0)
        }else {
            getNextClass()
            getUserAndSetTitle()
        }
    }
    
    func editClasses(){
        presentViewController(makeUserClasses(), animated: true, completion: nil)
    }
    
    func scheduleButtonPress(){
        mapImage.removeFromSuperview()
        view.addSubview(scheduleImage)
        containerViewXConstraint?.active = false
        containerViewYConstraint?.active = false
        containerViewHConstraint?.active = false
        containerViewWConstraint?.active = false
        
        mapContainerViewXConstraint?.active = false
        mapContainerViewWConstraint?.active = false
        mapContainerViewYConstraint?.active = false
        mapContainerViewHConstraint?.active = false
        
        scheduleContainerViewHConstraint?.active = true
        scheduleContainerViewYConstraint?.active = true
        scheduleContainerViewWConstraint?.active = true
        scheduleContainerViewXConstraint?.active = true
        setScheduleImage()
        
        scheduleButtonHConstraint?.constant = 66
        scheduleButtonWConstraint?.constant = 66
        scheduleView.layer.cornerRadius = 33
        scheduleView.tintColor = UIColor.darkGrayColor()
        homeButtonHConstraint?.constant = 56
        homeButtonWConstraint?.constant = 56
        homeView.layer.cornerRadius = 28
        homeView.tintColor = UIColor.grayColor()
        mapButtonHConstraint?.constant = 56
        mapButtonWConstraint?.constant = 56
        mapView.layer.cornerRadius = 28
        mapView.tintColor = UIColor.grayColor()
    }
    
    func mapButtonPress(){
        scheduleImage.removeFromSuperview()
        view.addSubview(mapImage)
        
        mapContainerViewXConstraint?.active = true
        mapContainerViewWConstraint?.active = true
        mapContainerViewYConstraint?.active = true
        mapContainerViewHConstraint?.active = true
        let requestObj = NSURLRequest(URL: url!);
        mapViewContainer.loadRequest(requestObj)
        
        scheduleButtonHConstraint?.constant = 56
        scheduleButtonWConstraint?.constant = 56
        scheduleView.layer.cornerRadius = 28
        scheduleView.tintColor = UIColor.grayColor()
        homeButtonHConstraint?.constant = 56
        homeButtonWConstraint?.constant = 56
        homeView.layer.cornerRadius = 28
        homeView.tintColor = UIColor.grayColor()
        mapButtonHConstraint?.constant = 66
        mapButtonWConstraint?.constant = 66
        mapView.layer.cornerRadius = 33
        mapView.tintColor = UIColor.darkGrayColor()
    }
    
    func homeButtonPress(){
        mapImage.removeFromSuperview()
        scheduleImage.removeFromSuperview()
        mapContainerViewXConstraint?.active = false
        mapContainerViewWConstraint?.active = false
        mapContainerViewYConstraint?.active = false
        mapContainerViewHConstraint?.active = false
        
        containerViewXConstraint?.active = true
        containerViewYConstraint?.active = true
        containerViewHConstraint?.active = true
        containerViewWConstraint?.active = true
        
        scheduleButtonHConstraint?.constant = 56
        scheduleButtonWConstraint?.constant = 56
        scheduleView.layer.cornerRadius = 28
        scheduleView.tintColor = UIColor.grayColor()
        homeButtonHConstraint?.constant = 66
        homeButtonWConstraint?.constant = 66
        homeView.layer.cornerRadius = 33
        homeView.tintColor = UIColor.darkGrayColor()
        mapButtonHConstraint?.constant = 56
        mapButtonWConstraint?.constant = 56
        mapView.layer.cornerRadius = 28
        mapView.tintColor = UIColor.grayColor()
    }
    
    
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
    
    func getClass1(){
        var classOne: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("classes")
        ref.child("class1").observeEventType(.Value, withBlock: { (snapshot) in
            classOne = snapshot.value as? String
            self.nextClass.text = classOne
        }, withCancelBlock: nil)
    
    }
    
    func getClass2(){
        var classTwo: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("classes")
        ref.child("class2").observeEventType(.Value, withBlock: { (snapshot) in
            classTwo = snapshot.value as? String
            self.nextClass.text = classTwo
            }, withCancelBlock: nil)
      
    }
    
    func getClass3(){
        var clas: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("classes")
        ref.child("class3").observeEventType(.Value, withBlock: { (snapshot) in
            clas = snapshot.value as? String
            self.nextClass.text = clas
            }, withCancelBlock: nil)
        
    }
    
    func getClass4(){
        var clas: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("classes")
        ref.child("class4").observeEventType(.Value, withBlock: { (snapshot) in
            clas = snapshot.value as? String
            self.nextClass.text = clas
            }, withCancelBlock: nil)
        
    }
    
    func getClass5(){
        var clas: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("classes")
        ref.child("class5").observeEventType(.Value, withBlock: { (snapshot) in
            clas = snapshot.value as? String
            self.nextClass.text = clas
            }, withCancelBlock: nil)
        
    }
    
    func getClass6(){
        var clas: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("classes")
        ref.child("class6").observeEventType(.Value, withBlock: { (snapshot) in
            clas = snapshot.value as? String
            self.nextClass.text = clas
            }, withCancelBlock: nil)
        
    }
    
    func getClass7(){
        var clas: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("classes")
        ref.child("class7").observeEventType(.Value, withBlock: { (snapshot) in
            clas = snapshot.value as? String
            self.nextClass.text = clas
            }, withCancelBlock: nil)
        
    }
    
    func getClass8(){
        var clas: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("classes")
        ref.child("class8").observeEventType(.Value, withBlock: { (snapshot) in
            clas = snapshot.value as? String
            self.nextClass.text = clas
            }, withCancelBlock: nil)
        
    }
    
    func getLocation1(){
        var location: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("locations")
        ref.child("class1").observeEventType(.Value, withBlock: { (snapshot) in
            location = snapshot.value as? String
            self.nextLocation.text = location
            }, withCancelBlock: nil)
        
    }
    
    func getLocation2(){
        var location: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("locations")
        ref.child("class2").observeEventType(.Value, withBlock: { (snapshot) in
            location = snapshot.value as? String
            self.nextLocation.text = location
            }, withCancelBlock: nil)
        
    }
    
    func getLocation3(){
        var location: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("locations")
        ref.child("class3").observeEventType(.Value, withBlock: { (snapshot) in
            location = snapshot.value as? String
            self.nextLocation.text = location
            }, withCancelBlock: nil)
        
    }
    
    func getLocation4(){
        var location: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("locations")
        ref.child("class4").observeEventType(.Value, withBlock: { (snapshot) in
            location = snapshot.value as? String
            self.nextLocation.text = location
            }, withCancelBlock: nil)
        
    }
    
    func getLocation5(){
        var location: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("locations")
        ref.child("class5").observeEventType(.Value, withBlock: { (snapshot) in
            location = snapshot.value as? String
            self.nextLocation.text = location
            }, withCancelBlock: nil)
        
    }
    
    func getLocation6(){
        var location: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("locations")
        ref.child("class6").observeEventType(.Value, withBlock: { (snapshot) in
            location = snapshot.value as? String
            self.nextLocation.text = location
            }, withCancelBlock: nil)
        
    }

    func getLocation7(){
        var location: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("locations")
        ref.child("class7").observeEventType(.Value, withBlock: { (snapshot) in
            location = snapshot.value as? String
            self.nextLocation.text = location
            }, withCancelBlock: nil)
        
    }
    
    func getLocation8(){
        var location: String?
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("locations")
        ref.child("class8").observeEventType(.Value, withBlock: { (snapshot) in
            location = snapshot.value as? String
            self.nextLocation.text = location
            }, withCancelBlock: nil)
        
    }


    
    func handleLogout(){
        do {
            try FIRAuth.auth()?.signOut()
        }catch let logouterror{
            print(logouterror)
        }
        let lo = LoginController()
        lo.viewController = self
        presentViewController(lo, animated: true, completion: nil)
    }
    
    func getUserAndSetTitle(){
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                self.navigationItem.title = dictionary["name"] as? String
            }
            }, withCancelBlock: nil)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

