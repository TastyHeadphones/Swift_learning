//
//  PhotoStore.swift
//  Photorama
//
//  Created by Magic Keegan on 11/19/21.
//

import Foundation

class PhotoStore{
    private let session:URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchInterstingPhotos(){
        let url = FlickAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request){
            (data,response,error) in
            if let jsonData = data{
                if let jsonString = String(data: jsonData, encoding: .utf8){
                print(jsonString)
            }
            else if let requestError = error{
                print("Error fetching interesting photos: \(requestError)")
            }
            else{
                print("Unexpected error with the request")
            }
            }
        }
        task.resume()
    }
}
