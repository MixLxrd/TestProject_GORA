//
//  Photos.swift
//  TestProject_GORA
//
//  Created by Михаил on 19.08.2021.
//

import Foundation

// MARK: - Photo
struct Photo: Decodable {
    let albumId, id: Int
    let title: String
    let url, thumbnailUrl: String
}

typealias Photos = [Photo]
