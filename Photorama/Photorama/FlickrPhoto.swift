//
//  Photo.swift
//  Photorama
//
//  Created by Magic Keegan on 11/20/21.
//

import Foundation

class FlickrPhoto: Codable{
    let title: String
    let remoteURL: URL?
    let photoID: String
    let dateTaken: Date
    
    enum CodingKeys: String,CodingKey{
        case title
        case remoteURL = "url_z"
        case photoID = "id"
        case dateTaken = "datetaken"
    }
}

extension FlickrPhoto:Equatable{
    static func == (lhs: FlickrPhoto,rhs: FlickrPhoto) -> Bool{
        return lhs.photoID == rhs.photoID
    }
}
