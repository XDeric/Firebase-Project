//
//  ImageCollectionViewController.swift
//  FirebaseProject
//
//  Created by EricM on 11/22/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit
import FirebaseAuth

class ImageCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var posts = [Post]() {
        didSet {
            self.imageCollection.reloadData()
        }
    }
    
    lazy var imageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset.right = 10
        layout.sectionInset.left = 10
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        collection.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionViewCell else{return UICollectionViewCell()}
        
        cell.imageView.image = UIImage(named: "noPic")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 185, height: 150)
    }
    
    @objc func logoffButton(){
        do {
            try Auth.auth().signOut()
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
        } catch {print(error)}
    }
    
    
    
    //MARK: views loading up
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        view.addSubview(imageCollection)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoffButton))
        collectionConstraint()
        // Do any additional setup after loading the view.
    }
    
    private func loadData(){
        FirestoreService.manager.getPosts { (result) in
            switch result {
            case .success(let postsFromFirebase):
                self.posts = postsFromFirebase
            case .failure(let error):
                print(error)
            }
        }
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
