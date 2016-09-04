//
//  makeClass8.swift
//  SM Schedule
//
//  Created by Luc Cote on 8/17/16.
//  Copyright © 2016 EduApp. All rights reserved.
//

import UIKit
import Firebase

class makeClass8: UIViewController {
    
    let classLabel: UILabel = {
        let l = UILabel()
        l.text = "Saturday:"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let locationLabel: UILabel = {
        let l = UILabel()
        l.text = "Location:"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    let classTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Your Saturday Class"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let locationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Location"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var doneButton: UIButton = {
        let b = UIButton(type: .System)
        b.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        b.setTitle("Done", forState: .Normal)
        b.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        b.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(handleNext), forControlEvents: .TouchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        // Do view setup here.
        view.addSubview(inputsContainerView)
        view.addSubview(doneButton)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        
        inputsContainerView.heightAnchor.constraintEqualToConstant(200).active = true
        inputsContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -50).active = true
        inputsContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputsContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -24).active = true
        
        inputsContainerView.addSubview(classLabel)
        inputsContainerView.addSubview(classTextField)
        inputsContainerView.addSubview(seperatorView)
        inputsContainerView.addSubview(locationLabel)
        inputsContainerView.addSubview(locationTextField)
        
        classLabel.topAnchor.constraintEqualToAnchor(inputsContainerView.topAnchor).active = true
        classLabel.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        classLabel.heightAnchor.constraintEqualToConstant(50).active = true
        classLabel.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        
        classTextField.topAnchor.constraintEqualToAnchor(classLabel.bottomAnchor).active = true
        classTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        classTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        classTextField.heightAnchor.constraintEqualToConstant(50).active = true
        
        seperatorView.topAnchor.constraintEqualToAnchor(classTextField.bottomAnchor).active = true
        seperatorView.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        seperatorView.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        seperatorView.heightAnchor.constraintEqualToConstant(1).active = true
        
        locationLabel.topAnchor.constraintEqualToAnchor(classTextField.bottomAnchor).active = true
        locationLabel.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        locationLabel.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        locationLabel.heightAnchor.constraintEqualToConstant(50).active = true
        
        locationTextField.topAnchor.constraintEqualToAnchor(locationLabel.bottomAnchor).active = true
        locationTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        locationTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        locationTextField.heightAnchor.constraintEqualToConstant(50).active = true
        
        doneButton.topAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: 12).active = true
        doneButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        doneButton.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        doneButton.heightAnchor.constraintEqualToConstant(50).active = true
        
    }
    
    func handleNext(){
        print("called Handler")
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid)
        let class8 = classTextField.text
        let class8Location = locationTextField.text
        
        ref.child("classes").child("class8").setValue(class8)
        ref.child("locations").child("class8").setValue(class8Location)
        self.view.window!.rootViewController!.dismissViewControllerAnimated(true, completion:nil)
        
        
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        locationTextField.resignFirstResponder()
        classTextField.resignFirstResponder()
        
    }
    
}
