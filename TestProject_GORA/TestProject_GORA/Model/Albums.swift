//
//  Albums.swift
//  TestProject_GORA
//
//  Created by Михаил on 19.08.2021.
//

import Foundation

// MARK: - Album
struct Album: Decodable {
    let userId, id: Int
    let title: String
}

typealias Albums = [Album]
