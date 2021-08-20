//
//  PhotosViewController.swift
//  TestProject_GORA
//
//  Created by Михаил on 19.08.2021.
//

import UIKit
import Kingfisher

class PhotosViewController: UIViewController {
    
    private let networkDataFetcher = NetworkDataFetcher()
    var photos: Photos?
    var albumsPhoto: [Photo] = []
    var albums: Albums?
    var userID: Int?
    var albumID: [Int] = []
    var sortedPhotos: Photos? {
        didSet {
            usersCollectionView.reloadData()
        }
    }
    
    
    private lazy var usersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        collectionView.toAutoLayout()
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        fetchPhotos()
        fetchAlbums() 
    }
    
}

extension PhotosViewController {
    private func setupLayout() {
        title = "Photos"
        view.addSubview(usersCollectionView)
        let constraints = [
            usersCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            usersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func fetchPhotos() {
        networkDataFetcher.fetchPhotos() { response in
            guard let search = response else { return }
            self.photos = search
            for item in self.albumID {
                _ = self.photos?.filter({ (photo: Photo) -> Bool in
                    if photo.albumId == item {
                        self.albumsPhoto.append(photo)
                    }
                    return photo.albumId == item
                })
            }
            self.sortedPhotos = self.albumsPhoto
        }
    }
    
    private func fetchAlbums() {
        networkDataFetcher.fetchAlbums() { response in
            guard let search = response else { return }
            self.albums = search
            _ = self.albums?.filter ({ (album: Album) -> Bool in
                if album.userId == self.userID {
                    self.albumID.append(album.id)
                }
                return album.userId == self.userID
            })
            
        }
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        cell.namePhotoLabel.text = sortedPhotos?[indexPath.row].title
        let url = URL(string: sortedPhotos?[indexPath.row].url ?? "")
        DispatchQueue.main.async {
            cell.photosImageView.kf.indicatorType = .activity
            cell.photosImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    var offset: CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (UIScreen.main.bounds.width - offset * 2), height: (UIScreen.main.bounds.width - offset * 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: offset, left: offset, bottom: offset, right: offset)
    }
}
