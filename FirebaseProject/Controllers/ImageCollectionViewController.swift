//
//  ImageCollectionViewController.swift
//  FirebaseProject
//
//  Created by EricM on 11/22/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit
import FirebaseAuth

class ImageCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    lazy var imageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        collection.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionViewCell else{return UICollectionViewCell()}
        
        cell.imageView.image = UIImage(named: "noPic")
        
        return cell
    }
    
    @objc func logoffButton(){
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {print(error)}
    }
    
    @objc func addItems(){
        let uploadVC = UINavigationController(rootViewController: ImageUploadViewController())
        uploadVC.modalPresentationStyle = .fullScreen
        present(uploadVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        view.addSubview(imageCollection)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoffButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItems))
        collectionConstraint()
        
        // Do any additional setup after loading the view.
    }
    
    private func collectionConstraint(){
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageCollection.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageCollection.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
    }
    
    
    
}
