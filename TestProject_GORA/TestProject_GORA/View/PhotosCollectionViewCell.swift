//
//  PhotosCollectionViewCell.swift
//  TestProject_GORA
//
//  Created by Михаил on 19.08.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    lazy var photosImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.sizeToFit()
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    lazy var namePhotoLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupLayout()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
}

extension PhotosCollectionViewCell {
    private func setupLayout() {
        contentView.addSubview(photosImageView)
        contentView.addSubview(namePhotoLabel)
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderWidth = 0.1
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 3.0
        contentView.layer.masksToBounds = true
        let constraints = [
            photosImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photosImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photosImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photosImageView.bottomAnchor.constraint(equalTo: namePhotoLabel.topAnchor, constant: -8),
            
            namePhotoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            namePhotoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            namePhotoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
