//
//  ImageCollectionViewCell.swift
//  FirebaseProject
//
//  Created by EricM on 11/22/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        self.addSubview(image)
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        backgroundColor = .white
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        setImage()
    }
    
    private func setImage() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
    
}
