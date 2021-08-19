//
//  NetworkDataFetcher.swift
//  TestProject_GORA
//
//  Created by Михаил on 19.08.2021.
//

import Foundation

class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    func fetchUsers(response: @escaping (Users?) -> Void) {
        networkService.request(urlString: "https://jsonplaceholder.typicode.com/users") { (result) in
            switch result {
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(Users.self, from: data)
                    response(tracks)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
    func fetchAlbums(response: @escaping (Albums?) -> Void) {
        networkService.request(urlString: "https://jsonplaceholder.typicode.com/albums") { (result) in
            switch result {
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(Albums.self, from: data)
                    response(tracks)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
    func fetchPhotos(response: @escaping (Photos?) -> Void) {
        networkService.request(urlString: "https://jsonplaceholder.typicode.com/photos") { (result) in
            switch result {
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(Photos.self, from: data)
                    response(tracks)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
}
