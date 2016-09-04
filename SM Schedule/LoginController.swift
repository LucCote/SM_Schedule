//
//  LoginController.swift
//  FireMessenger
//
//  Created by Luc Cote on 7/30/16.
//  Copyright © 2016 ClickyApps. All rights reserved.
//

import UIKit
import Firebase
class LoginController: UIViewController {
    
    var viewController: ViewController?
    
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tfa = UITextField()
        tfa.placeholder = "Password"
        tfa.translatesAutoresizingMaskIntoConstraints = false
        tfa.secureTextEntry = true
        return tfa
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.whiteColor()
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), forControlEvents: .ValueChanged)
        return sc
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let b = UIButton(type: .System)
        b.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        b.setTitle("Register", forState: .Normal)
        b.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        b.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(handleLoginRegister), forControlEvents: .TouchUpInside)
        return b
    }()
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "profileImage")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    var inputsContainerViewHAnchor: NSLayoutConstraint?
    var nameTextFieldHAnchor: NSLayoutConstraint?
    var emailTextFieldHAnchor: NSLayoutConstraint?
    var passwordTextFieldHAnchor: NSLayoutConstraint?
    
    func handleLoginRegisterChange(){
        let title = loginRegisterSegmentedControl.titleForSegmentAtIndex(loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, forState: .Normal)
        inputsContainerViewHAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        let nameselector: CGFloat = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3
        nameTextFieldHAnchor?.active = false
        nameTextFieldHAnchor = nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: nameselector)
        nameTextFieldHAnchor?.active = true
        let epselector: CGFloat = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3
        emailTextFieldHAnchor?.active = false
        passwordTextFieldHAnchor?.active = false
        emailTextFieldHAnchor = emailTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: epselector)
        passwordTextFieldHAnchor = passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: epselector)
        emailTextFieldHAnchor?.active = true
        passwordTextFieldHAnchor?.active = true

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        
        
        
        view.addSubview(inputsContainerView)
        
        view.addSubview(loginRegisterButton)
        
        
        let NameSeperatorView = UIView()
        NameSeperatorView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        NameSeperatorView.translatesAutoresizingMaskIntoConstraints = false
        
        let EmailSeperatorView = UIView()
        EmailSeperatorView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        EmailSeperatorView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileImageView)
        
        view.addSubview(loginRegisterSegmentedControl)
        
        inputsContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputsContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        inputsContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -24).active = true
        inputsContainerViewHAnchor = inputsContainerView.heightAnchor.constraintEqualToConstant(150)
        inputsContainerViewHAnchor?.active = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(NameSeperatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(EmailSeperatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        nameTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        nameTextField.topAnchor.constraintEqualToAnchor(inputsContainerView.topAnchor).active = true
        nameTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        nameTextFieldHAnchor = nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHAnchor?.active = true
        
        NameSeperatorView.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor).active = true
        NameSeperatorView.topAnchor.constraintEqualToAnchor(nameTextField.bottomAnchor).active = true
        NameSeperatorView.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        NameSeperatorView.heightAnchor.constraintEqualToConstant(1).active = true
        
        emailTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        emailTextField.topAnchor.constraintEqualToAnchor(NameSeperatorView.bottomAnchor).active = true
        emailTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        emailTextFieldHAnchor = emailTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHAnchor?.active = true
        
        EmailSeperatorView.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor).active = true
        EmailSeperatorView.topAnchor.constraintEqualToAnchor(emailTextField.bottomAnchor).active = true
        EmailSeperatorView.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        EmailSeperatorView.heightAnchor.constraintEqualToConstant(1).active = true
        
        passwordTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        passwordTextField.topAnchor.constraintEqualToAnchor(EmailSeperatorView.bottomAnchor).active = true
        passwordTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        passwordTextFieldHAnchor = passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHAnchor?.active = true
    
        loginRegisterButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterButton.topAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: 12).active = true
        loginRegisterButton.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        loginRegisterButton.heightAnchor.constraintEqualToConstant(50).active = true
        
        profileImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        profileImageView.bottomAnchor.constraintEqualToAnchor(loginRegisterSegmentedControl.topAnchor, constant: -12).active = true
        profileImageView.widthAnchor.constraintEqualToConstant(100).active = true
        profileImageView.heightAnchor.constraintEqualToConstant(100).active = true
        
        loginRegisterSegmentedControl.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterSegmentedControl.bottomAnchor.constraintEqualToAnchor(inputsContainerView.topAnchor, constant: -12).active = true
        loginRegisterSegmentedControl.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        loginRegisterSegmentedControl.heightAnchor.constraintEqualToConstant(30).active = true
    }
    func handleLoginRegister(){
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        }else{
            handleRegister()
        }
    }
    func handleLogin(){
        guard let email = emailTextField.text, password = passwordTextField.text else{
            return
        }
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, signinerror) in
            if signinerror != nil{
                if let errer = signinerror?.userInfo["error_name"] as? String{
                    let alertController = UIAlertController(title: "Login Error", message:
                        errer, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }

            }else {
                self.viewController?.getNextClass()
                self.viewController?.getUserAndSetTitle()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        })
    }
    func handleRegister(){
        guard let email = emailTextField.text, password = passwordTextField.text, name = nameTextField.text else{
            let alertController = UIAlertController(title: "Invalid Form", message:
                "Please Fill Out All Information To Register", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            return
        }
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                if let errer = error?.userInfo["error_name"] as? String{
                    let alertController = UIAlertController(title: "Registration Error", message:
                        errer, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                return
            }else{
                guard let uid = user?.uid else{
                    return
                }
                
                let values = ["name": name, "email": email]
                self.registerToDatabase(uid, values: values)
            }
            
        })
    }
    func registerToDatabase(uid: String, values: [String: AnyObject]){
        let ref = FIRDatabase.database().reference()
        let usersref = ref.child("users").child(uid)
        usersref.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err)
                return
            }
            print("Saved User")
            self.viewController?.tellUserRefresh()
            self.viewController?.navigationItem.title = values["name"] as? String
            self.presentViewController(makeUserClasses(), animated: true, completion: nil)
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        emailTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
    }

    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
