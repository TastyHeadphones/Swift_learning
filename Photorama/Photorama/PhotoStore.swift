//
//  PhotoStore.swift
//  Photorama
//
//  Created by Magic Keegan on 11/19/21.
//

//import Foundation
import UIKit
import CoreData

enum PhotoError: Error{
    case imageCreationError
    case missingImageURL
}
class PhotoStore{
    let itemStore = ImageStore()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Photorama")
        container.loadPersistentStores{
            (description,error) in
            if let error = error {
                print("Error setting up Core Data (\(error)).")
            }
        }
        return container
    }()
    
    private let session:URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private func processPhotosRequest(data: Data?,error: Error?) ->Result<[Photo],Error>{
        guard let jsonData = data else{
            return .failure(error!)
        }
        
        let context = persistentContainer.viewContext
        
        switch FlickAPI.photos(fromJSON: jsonData){
        case let .success(FlickrPhotos):
            let photos = FlickrPhotos.map{
                flickrPhoto -> Photo in
                let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
                let predicate = NSPredicate(format: "\(#keyPath(Photo.photoID)) == \(flickrPhoto.photoID)")
                fetchRequest.predicate = predicate
                var fetchPhotos: [Photo]?
                
                context.performAndWait {
                    fetchPhotos = try? fetchRequest.execute()
                }
                if let existingPhoto = fetchPhotos?.first{
                    return existingPhoto
                }
                
                var photo: Photo!
                context.performAndWait {
                    photo = Photo(context:context)
                    photo.title = flickrPhoto.title
                    photo.photoID = flickrPhoto.photoID
                    photo.remoteURL = flickrPhoto.remoteURL
                    photo.dateTaken = flickrPhoto.dateTaken
                }
                return photo
            }
            return .success(photos)
        case let .failure(error):
            return .failure(error)
        }
//        return FlickAPI.photos(fromJSON: jsonData)
    }
    
    func fetchImage(for photo: Photo,completion: @escaping (Result<UIImage, Error>) -> Void){
        
        guard let photoKey = photo.photoID else {
            preconditionFailure("Photo expected to have a photoID.")
        }
        if let image = itemStore.image(forKey: photoKey){
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
            return
        }
        
        guard let photoURL = photo.remoteURL else{
            completion(.failure(PhotoError.missingImageURL))
            return
        }
        let requests = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: requests){
            (data,response,error) in
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .success(image) = result{
                self.itemStore.setImage(image, forKey: photoKey)
            }
            
            OperationQueue.main.addOperation{
                completion(result)
            }
            
        }
        task.resume()
    }
    
    private func processImageRequest(data: Data?,error: Error?) ->Result<UIImage,Error>{
        guard let imageData = data, let image = UIImage(data: imageData) else{
            if data == nil{
                return .failure(error!)
            }else{
                return.failure(PhotoError.imageCreationError)
            }
        }
        
        return .success(image)
    }
    
    func fetchInterstingPhotos(completion: @escaping (Result<[Photo], Error>) -> Void){
        let url = FlickAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request){
            (data,response,error) in
//            let result = self.processPhotosRequest(data: data, error: error)
            var result = self.processPhotosRequest(data: data, error: error)
            if case .success = result{
                do {
                    try self.persistentContainer.viewContext.save()
                }
                catch{
                    result = .failure(error)
                }
            }
            OperationQueue.main.addOperation {
                completion(result)
            }
            
            //            if let jsonData = data{
            //                if let jsonString = String(data: jsonData, encoding: .utf8){
            //                print(jsonString)
            //            }
            //            else if let requestError = error{
            //                print("Error fetching interesting photos: \(requestError)")
            //            }
            //            else{
            //                print("Unexpected error with the request")
            //            }
        }
        
        task.resume()
    }
    
    func fetchAllPhotos(completion: @escaping (Result<[Photo],Error>)-> Void){
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        let sortByDataTaken = NSSortDescriptor(key: #keyPath(Photo.dateTaken), ascending: true)
        fetchRequest.sortDescriptors = [sortByDataTaken]
        
        let viewContext = persistentContainer.viewContext
        do{
            let allPhotos = try viewContext.fetch(fetchRequest)
            completion(.success(allPhotos))
        }catch{
            completion(.failure(error))
        }
    }
}
