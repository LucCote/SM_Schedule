//
//  ScheduleViewAndMapView.swift
//  SM Schedule
//
//  Created by Luc Cote on 8/31/16.
//  Copyright © 2016 EduApp. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setUpMapAndSchedule(){
//        scheduleContainerViewHConstraint = scheduleViewContainer.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 64)
//        scheduleContainerViewYConstraint = scheduleViewContainer.bottomAnchor.constraintEqualToAnchor(viewSwitchContainerView.topAnchor)
//        scheduleContainerViewWConstraint = scheduleViewContainer.widthAnchor.constraintEqualToAnchor(view.widthAnchor)
//        scheduleContainerViewXConstraint = scheduleViewContainer.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        scheduleContainerViewHConstraint = scheduleImage.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 64)
        scheduleContainerViewYConstraint = scheduleImage.bottomAnchor.constraintEqualToAnchor(viewSwitchContainerView.topAnchor)
        scheduleContainerViewWConstraint = scheduleImage.widthAnchor.constraintEqualToAnchor(view.widthAnchor)
        scheduleContainerViewXConstraint = scheduleImage.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        scheduleContainerViewHConstraint?.active = false
        scheduleContainerViewYConstraint?.active = false
        scheduleContainerViewWConstraint?.active = false
        scheduleContainerViewXConstraint?.active = false
        
//        scheduleImage.centerXAnchor.constraintEqualToAnchor(scheduleViewContainer.centerXAnchor).active = true
//        scheduleImage.centerYAnchor.constraintEqualToAnchor(scheduleViewContainer.centerYAnchor).active = true
//        scheduleImage.heightAnchor.constraintEqualToAnchor(scheduleViewContainer.heightAnchor).active = true
//        scheduleImage.widthAnchor.constraintEqualToAnchor(scheduleViewContainer.widthAnchor).active = true
        
        mapContainerViewHConstraint = mapViewContainer.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 64)
        mapContainerViewYConstraint = mapViewContainer.bottomAnchor.constraintEqualToAnchor(viewSwitchContainerView.topAnchor)
        mapContainerViewWConstraint = mapViewContainer.widthAnchor.constraintEqualToAnchor(view.widthAnchor)
        mapContainerViewXConstraint = mapViewContainer.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        mapContainerViewXConstraint?.active = false
        mapContainerViewWConstraint?.active = false
        mapContainerViewYConstraint?.active = false
        mapContainerViewHConstraint?.active = false
        
    }
    
    func handleImagePress(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        var selectedImage: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImage = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImage = originalImage
        }
        
        if let selectImage = selectedImage{
            scheduleImage.image = selectImage
            uploadImage()
        }
        
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func uploadImage(){
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        if let uploadData = UIImageJPEGRepresentation(self.scheduleImage.image!, 0.5){
            let imageName = NSUUID().UUIDString
            let storageRef = FIRStorage.storage().reference().child("\(imageName).jpg")
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error)
                    return
                }
                if let profileImageURL = metadata?.downloadURL()?.absoluteString{
                    let ref = FIRDatabase.database().reference().child("users").child(uid).child("scheduleImage")
                    ref.setValue(profileImageURL)
                }
            })
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setScheduleImage(){
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("scheduleImage")
        ref.observeEventType(.Value, withBlock: { (snapshot) in
            if let downloadLink = snapshot.value as? String {
                self.scheduleImage.loadImageUsingCache(downloadLink)
            }else {
                self.scheduleImage.image = UIImage(named: "schedule")
            }
            }, withCancelBlock: nil)
    }

    
}