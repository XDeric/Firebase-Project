//
//  ImageUploadViewController.swift
//  FirebaseProject
//
//  Created by EricM on 11/22/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class ImageUploadViewController: UIViewController {

    //MARK: Variables 
    lazy var picture: UIImageView = {
        let image = UIImageView()
        
        
        return image
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        
        
        return button
    }()
    
    
    //MARK: Functions/Methods
    @objc func back(){
        let mainTabVC = TabBar()
        mainTabVC.modalPresentationStyle = .fullScreen
        self.present(mainTabVC, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))

        // Do any additional setup after loading the view.
    }
    
    //MARK: constrains


}
