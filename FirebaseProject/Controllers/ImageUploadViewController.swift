//
//  ImageUploadViewController.swift
//  FirebaseProject
//
//  Created by EricM on 11/22/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class ImageUploadViewController: UIViewController {

    //MARK: Variables
    
    var image = UIImage() {
        didSet {
            picture.image = image
        }
    }
    
    lazy var picture: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        return image
    }()
    
    lazy var uploadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.setTitle("Upload", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(uploadImage), for:.touchUpInside )
        return button
    }()
    
    lazy var setProfile: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.setTitle("Choose Profile Image", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(pickImage), for:.touchUpInside )
        return button
    }()
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    
    //MARK: Functions/Methods
    @objc func back(){
        let mainTabVC = TabBar()
        mainTabVC.modalPresentationStyle = .fullScreen
        self.present(mainTabVC, animated: true, completion: nil)
        
    }
    
    @objc func logoffButton(){
        do {
            try Auth.auth().signOut()
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
        } catch {print(error)}
    }
    
    @objc func uploadImage(){
        
    }
    
    @objc func pickImage(){
        present(imagePicker,animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoffButton))
        setUpConstraints()
    }
    
    //MARK: constrains

    private func setUpConstraints(){
        
        picture.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picture)
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            picture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picture.widthAnchor.constraint(equalToConstant: 350),
            picture.heightAnchor.constraint(equalToConstant: 300)
            
        ])
        
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(uploadButton)
        NSLayoutConstraint.activate([
            uploadButton.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 50),
            uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        setProfile.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(setProfile)
        NSLayoutConstraint.activate([
            setProfile.topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 50),
            setProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setProfile.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
}



extension ImageUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        self.image = image
        dismiss(animated: true, completion: nil)
    }
}
