//
//  File.swift
//  Talkrr
//
//  Created by Reva Tamaskar on 10/02/23.
//

import Foundation
import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    let usernameBG = UIView()
    let emailBG = UIView()
    let passwordBG = UIView()
    let confirmPasswordBG = UIView()
    
    let talkrr = UILabel()
    let emailCheckLabel = UILabel()
    let signUpLabel = UILabel()
    
    let usernameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField  = UITextField()
    
    let signUpButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
        
        let background = UIImage(named: "LoginPageBG")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        talkrr.text = "Talkrr"
        talkrr.font = UIFont(name: "DINCondensed-Bold", size: 80)
        talkrr.textColor = .white
        talkrr.textAlignment = .center
        view.addSubview(talkrr)
        talkrr.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            talkrr.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            talkrr.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -200),
            talkrr.heightAnchor.constraint(equalToConstant: 80),
            talkrr.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25)
        ])
        
        usernameBG.layer.cornerRadius = 7
        usernameBG.backgroundColor = .white
        view.addSubview(usernameBG)
        usernameBG.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameBG.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            usernameBG.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -120),
            usernameBG.heightAnchor.constraint(equalToConstant: 40),
            usernameBG.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40)
        ])
        
        usernameTextField.text = "Enter your full name"
        usernameTextField.backgroundColor = .clear
        usernameTextField.textColor = .lightGray
        view.addSubview(usernameTextField)
        usernameTextField.addTarget(self, action: #selector(clearText(sender: )), for: .touchUpInside)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.bottomAnchor.constraint(equalTo: usernameBG.bottomAnchor, constant: -5),
            usernameTextField.topAnchor.constraint(equalTo: usernameBG.topAnchor, constant: 5),
            usernameTextField.leadingAnchor.constraint(equalTo: usernameBG.leadingAnchor, constant: 5),
            usernameTextField.trailingAnchor.constraint(equalTo: usernameBG.trailingAnchor, constant: -5)
        ])
        
        emailBG.layer.cornerRadius = 7
        emailBG.backgroundColor = .white
        view.addSubview(emailBG)
        emailBG.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailBG.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailBG.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40),
            emailBG.heightAnchor.constraint(equalToConstant: 40),
            emailBG.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40)
        ])
        
        emailTextField.text = "Enter email"
        emailTextField.backgroundColor = .clear
        emailTextField.textColor = .lightGray
        emailTextField.keyboardType = .emailAddress
        view.addSubview(emailTextField)
        emailTextField.addTarget(self, action: #selector(clearText(sender: )), for: .touchUpInside)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.bottomAnchor.constraint(equalTo: emailBG.bottomAnchor, constant: -5),
            emailTextField.topAnchor.constraint(equalTo: emailBG.topAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: emailBG.leadingAnchor, constant: 5),
            emailTextField.trailingAnchor.constraint(equalTo: emailBG.trailingAnchor, constant: -5)
        ])
        
        emailCheckLabel.textColor = .white
        emailCheckLabel.font = UIFont(name: "HelveticaNeue", size: 12.5)
        view.addSubview(emailCheckLabel)
        emailCheckLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailCheckLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailCheckLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 3),
            emailCheckLabel.heightAnchor.constraint(equalToConstant: 20),
            emailTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        passwordBG.layer.cornerRadius = 7
        passwordBG.backgroundColor = .white
        view.addSubview(passwordBG)
        passwordBG.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordBG.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordBG.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40),
            passwordBG.heightAnchor.constraint(equalToConstant: 40),
            passwordBG.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40)
        ])
        
        passwordTextField.text = "Enter password"
        passwordTextField.backgroundColor = .white
        passwordTextField.textColor = .lightGray
        view.addSubview(passwordTextField)
        passwordTextField.addTarget(self, action: #selector(clearText(sender: )), for: .touchUpInside)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.bottomAnchor.constraint(equalTo: passwordBG.bottomAnchor, constant: -5),
            passwordTextField.topAnchor.constraint(equalTo: passwordBG.topAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordBG.leadingAnchor, constant: 5),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordBG.trailingAnchor, constant: -5)
        ])
        
        confirmPasswordBG.layer.cornerRadius = 7
        confirmPasswordBG.backgroundColor = .white
        view.addSubview(confirmPasswordBG)
        confirmPasswordBG.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmPasswordBG.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            confirmPasswordBG.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 120),
            confirmPasswordBG.heightAnchor.constraint(equalToConstant: 40),
            confirmPasswordBG.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40)
        ])
        
        confirmPasswordTextField.text = "Confirm password"
        confirmPasswordTextField.backgroundColor = .clear
        confirmPasswordTextField.textColor = .lightGray
        view.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.addTarget(self, action: #selector(clearText(sender: )), for: .touchUpInside)
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmPasswordTextField.bottomAnchor.constraint(equalTo: confirmPasswordBG.bottomAnchor, constant: -5),
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordBG.topAnchor, constant: 5),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: confirmPasswordBG.leadingAnchor, constant: 5),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: confirmPasswordBG.trailingAnchor, constant: -5)
        ])
        
        signUpLabel.textColor = .white
        signUpLabel.font = UIFont(name: "HelveticaNeue", size: 12.5)
        signUpLabel.textAlignment = .center
        view.addSubview(signUpLabel)
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signUpLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 3),
            signUpLabel.heightAnchor.constraint(equalToConstant: 20),
            signUpLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.layer.cornerRadius = 7
        signUpButton.backgroundColor = .black
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 40),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signUpButton.widthAnchor.constraint(equalToConstant: 100),
            signUpButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40)
        ])
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
        self.view.backgroundColor = .systemBackground
    }
    
    @objc func clearText(sender: UITextField){
        sender.text = ""
        sender.textColor = .black
        
        if sender == passwordTextField || sender == confirmPasswordTextField {
            sender.text = ""
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
    
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func signUpButtonClicked() {
        emailCheckLabel.text = ""
        signUpLabel.text = ""
        
        if emailTextField.text?.count ?? 0 <= 5 {
            if emailTextField.text?.count == 0 {
                emailCheckLabel.text = "enter email address"
            }
            else {
                emailCheckLabel.text = "invalid email address"
            }
        }
        else {
            if passwordTextField.text == ""  || passwordTextField.text == nil{
                signUpLabel.text = "enter password"
            }
            else if passwordTextField.text!.count < 6 {
                signUpLabel.text = "Password must have atleast 6 characters."
            }
            else {
                if confirmPasswordTextField.text == ""  || confirmPasswordTextField.text == nil{
                    signUpLabel.text = "enter password"
                }
                else if confirmPasswordTextField.text !=  passwordTextField.text {
                    signUpLabel.text = "Passwords don't match."
                }
            }
        }
        
        let email = emailTextField.text
        let password = passwordTextField.text
        let username = usernameTextField.text
        
        if email != nil && password != nil {
            Auth.auth().createUser(withEmail: email!, password: password!, completion:
            {(user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    self.signUpLabel.text = error.localizedDescription
                    return
                }
                print("registered")
                self.dismiss(animated: true, completion: nil)
                
                let ref = Database.database().reference().child("Users").child(user!.user.uid)
                let values = ["email": email, "username": username]
                ref.updateChildValues(values as [AnyHashable : Any]) { (err,ref) in
                    if err != nil {
                        print(err!)
                        return
                    }
                    print("Saved and Updated New User")
                }
            })
        }
    }
}


