//
//  LoginViewController.swift
//  FirebaseProject
//
//  Created by EricM on 11/19/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    //MARK: view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        // Do any additional setup after loading the view.
    }
        //MARK: items on view
        
        lazy var emailTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Email"
            textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            textField.borderStyle = .roundedRect
            textField.font = UIFont.systemFont(ofSize: 14)
            textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
            return textField
        }()
        
        lazy var userNameTextField: UITextField = {
            let textField = UITextField()
             textField.placeholder = "UserName"
             textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
             textField.borderStyle = .roundedRect
             textField.font = UIFont.systemFont(ofSize: 14)
             textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
             return textField
        }()
        
        
        lazy var fullNameTextField: UITextField = {
            let textField = UITextField()
             textField.placeholder = "Full Name"
             textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
             textField.borderStyle = .roundedRect
             textField.font = UIFont.systemFont(ofSize: 14)
             textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
             return textField
        }()
        
        
        lazy var passwordTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Password"
            textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            textField.borderStyle = .roundedRect
            textField.font = UIFont.systemFont(ofSize: 14)
            textField.isSecureTextEntry = true
            textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
            return textField
        }()
        
        lazy var signUpButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Sign up", for: .normal)
         button.setTitleColor(UIColor(red: 247/255, green: 242/255, blue: 242/255, alpha: 0.7), for: .normal)
         button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            button.layer.cornerRadius = 5
            button.addTarget(self, action: #selector(handleSignupPressed), for: .touchUpInside)
            button.isEnabled = false
            return button
        }()
    
    //MARK: items functions
    
    @objc func handleShowLogin() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func formValidation() {
        guard emailTextField.hasText, passwordTextField.hasText, fullNameTextField.hasText, userNameTextField.hasText else {
            signUpButton.backgroundColor = UIColor(red: 129/255, green: 93/255, blue: 93/255, alpha: 1)
            signUpButton.isEnabled = false
            return
        }
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor(red: 129/255, green: 27/255, blue: 27/255, alpha: 1)
        
    }
    
    
    @objc func handleSignupPressed() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(withTitle: "Error", andMessage: "Failed to create account")
            print("Failed to sign up")
            return
        }
        FirebaseAuthService.manager.createNewUser(withEmail: email, password: password) { [weak self] (result) in
            self?.handleCreateAccountResponse(with: result)
        }
    }
    
    private func handleCreateAccountResponse(with result: Result<User, Error>) {
        switch result {
        case .success(let user):
            FirebaseAuthService.manager.updateUserName(userName: self.userNameTextField.text ?? "NA")
            FirestoreService.manager.createAppUser(user: AppUser(from: user)) { [weak self] newResult in
                self?.handleCreatedUserInFirestore(result: newResult)
            }
        case .failure(let error):
            showAlert(withTitle: "Error creating user", andMessage: "an error occured while creating new account \(error)")
        }
    }
    
    private func handleCreatedUserInFirestore(result: Result<Void, Error>) {
        switch result {
        case .success:
            let mainTabVC = MainTabVC()
            mainTabVC.modalPresentationStyle = .fullScreen
            present(mainTabVC, animated: true, completion: nil)
            
        case .failure(let error):
            print("error adding user to firestore \(error)")
        }
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //MARK: Setup constraints
        
    
    

}
