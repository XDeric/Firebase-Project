//
//  ViewController.swift
//  FirebaseProject
//
//  Created by EricM on 11/18/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: Profile pic
    
    lazy var profilePic: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let radius = image.frame.size.width / 2
        image.layer.cornerRadius = radius
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 0.5
        image.image = UIImage(named: "noPic")
        return image
    }()
    
    //MARK: Login stuff
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textField
    }()
    
    @objc func formValidation() {
        guard emailTextField.hasText, passwordTextField.hasText else {
            loginButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            loginButton.isEnabled = false
            return
        }
        loginButton.isEnabled = true
        loginButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
    }
    
    lazy var makeAccount: UIButton = {
        
        let button = UIButton(type: .system)
      
        let atttributedTitle = NSMutableAttributedString(string: "Dont have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        atttributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:  UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        button.setAttributedTitle(atttributedTitle, for: .normal)
        //button.backgroundColor = .blue
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
        
    }()
    
    @objc func handleShowSignUp() {
        let signupVC = SignUpViewController()
        signupVC.modalPresentationStyle = .fullScreen
        present(signupVC, animated: true, completion: nil)
        
    }
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLoginPressed), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
        @objc func handleLoginPressed(){
            guard let email = emailTextField.text , let password = passwordTextField.text else {
                showAlert(withTitle: "Error", andMessage: "Invalid Fields")
                return
            }
            FirebaseAuthService.manager.loginUser(withEmail: email, password: password) { (result) in
                self.handleLoginResponse(with: result)
            }
        }
    
        private func handleLoginResponse(with result: Result<User, Error>) {
            switch result{
            case .failure(let error):
                self.showAlert(withTitle: "Error", andMessage: "\(error)")
            case .success:
                let mainTabVC = TabBar()
                mainTabVC.modalPresentationStyle = .fullScreen
                self.present(mainTabVC, animated: true, completion: nil)
            }
        }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
    //MARK: View loads
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        view.addSubview(profilePic)
        setupMakeAccountButton()
        setupStackViewForTextFieldsAndButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setProfileImage()
    }
    
    
    //MARK: Constraints
    private func setProfileImage() {
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(profilePic)
        
        NSLayoutConstraint.activate([
            
            profilePic.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profilePic.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            profilePic.widthAnchor.constraint(equalToConstant: 200),
            profilePic.heightAnchor.constraint(equalToConstant: 200)])
        
    }
    
    private func setupStackViewForTextFieldsAndButton() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 50),
                                     stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                                     stackView.heightAnchor.constraint(equalToConstant: 130)])
        
    }
    
    private func setupMakeAccountButton() {
        view.addSubview(makeAccount)
        makeAccount.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([makeAccount.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     makeAccount.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     makeAccount.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     makeAccount.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    
}
