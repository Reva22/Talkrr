//
//  ViewController.swift
//  Talkrr
//
//  Created by Reva Tamaskar on 10/02/23.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let talkrr = UILabel()
    
    let emailView = UIView()
    let emailTextField = UITextField()
    
    let emailCheckLabel = UILabel()
    
    let passwordView = UIView()
    let passwordTextField = UITextField()
    
    let loginLabel = UILabel()
    
    let loginButton = UIButton()
    let registerButton = UIButton()
    let forgotPasswordButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            talkrr.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -120),
            talkrr.heightAnchor.constraint(equalToConstant: 80),
            talkrr.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25)
        ])
        
        emailView.backgroundColor = .white
        emailView.layer.cornerRadius = 7
        view.addSubview(emailView)
        emailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -35),
            emailView.heightAnchor.constraint(equalToConstant: 40),
            emailView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25)
        ])
        
        emailTextField.text = "Enter your email address"
        emailTextField.backgroundColor = .clear
        emailTextField.textColor = .lightGray
        emailTextField.keyboardType = .emailAddress
        emailTextField.addTarget(self, action: #selector(clearText(sender:)), for: .editingDidBegin)
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.bottomAnchor.constraint(equalTo: emailView.bottomAnchor, constant: -5),
            emailTextField.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 7),
            emailTextField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -7)
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
        
        passwordView.backgroundColor = .white
        passwordView.layer.cornerRadius = 7
        view.addSubview(passwordView)
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 35),
            passwordView.heightAnchor.constraint(equalToConstant: 40),
            passwordView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25)
        ])
        
        passwordTextField.text = "Enter your password"
        passwordTextField.textColor = .lightGray
        passwordTextField.backgroundColor = .clear
        passwordTextField.addTarget(self, action: #selector(clearText(sender:)), for: .editingDidBegin)
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -5),
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 7),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -7)
        ])
        
        loginLabel.textColor = .white
        loginLabel.textAlignment = .center
        loginLabel.font = UIFont(name: "HelveticaNeue", size: 12.5)
        view.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 3),
            loginLabel.heightAnchor.constraint(equalToConstant: 20),
            loginLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.cornerRadius = 7
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25)
        ])
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        registerButton.setTitleColor(.white, for: .normal)
        view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            registerButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
        view.addSubview(forgotPasswordButton)
        let attributedString = NSAttributedString(string: NSLocalizedString("Forgot Password?", comment: ""), attributes:[
            NSAttributedString.Key.underlineStyle:1.0
        ])
        forgotPasswordButton.setAttributedTitle(attributedString, for: .normal)
        forgotPasswordButton.setTitleColor(.white, for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonClicked), for: .touchUpInside)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forgotPasswordButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40),
            forgotPasswordButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25)
        ])
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func loginButtonClicked() {
        
        emailCheckLabel.text = ""
        loginLabel.text = ""
        
        if emailTextField.text?.count ?? 0 <= 5 {
            if emailTextField.text?.count == 0 {
                emailCheckLabel.text = "enter email address"
            }
            else {
                emailCheckLabel.text = "invalid email address"
            }
        }
        else {
            if passwordTextField.text == "" {
                loginLabel.text = "enter password"
            }
        }
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        Auth.auth().signIn(withEmail: email!, password: password!, completion:
            {(user, error) in
            if let error = error {
                if error.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                    self.loginLabel.text = "User not found. Please register."
                }
                else {
                    self.loginLabel.text = "Incorrect account details"
                }
                return
            }
            
            let rootVC = SelectUserViewController()
            rootVC.title = "Talkrr"
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: false)
        })
        
        
    }
    
    @objc func registerButtonClicked() {
        let rootVC = RegisterViewController()
        rootVC.title = "Register"
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationBar.tintColor = .black
        present(navVC, animated: false)
    }
    
    @objc func forgotPasswordButtonClicked() {
        if (!emailTextField.text!.isEmpty) {
            let email = self.emailTextField.text
            
            Auth.auth().sendPasswordReset(withEmail: email!, completion: { (error) in
                if let error = error {
                    Utilities().ShowAlert(title: "Error", message: error.localizedDescription, vc: self)
                    return
                }
                Utilities().ShowAlert(title: "Success!", message: "Please check your email!", vc: self)
            })
        }
    }
    
    @objc func clearText(sender: UITextField){
        sender.text = ""
        sender.textColor = .black
        
        if sender == passwordTextField {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @objc func didTapView(){
        self.view.endEditing(true)
    }
}
