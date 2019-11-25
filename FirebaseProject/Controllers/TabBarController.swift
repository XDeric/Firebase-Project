//
//  TabBarController.swift
//  FirebaseProject
//
//  Created by EricM on 11/24/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import UIKit

class TabBar: UITabBarController {
    
    let imageVC = UINavigationController(rootViewController: ImageCollectionViewController())
    let uploadVC = UINavigationController(rootViewController: ImageUploadViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        uploadVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        self.viewControllers = [imageVC, uploadVC]
    }
    
    
    
    
}
