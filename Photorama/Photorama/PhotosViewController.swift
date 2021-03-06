//
//  ViewController.swift
//  Photorama
//
//  Created by Magic Keegan on 11/15/21.
//

import UIKit

class PhotosViewController: UIViewController,UICollectionViewDelegate {
    
//    @IBOutlet private var imageView: UIImageView!
    @IBOutlet var collctionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collctionView.dataSource = photoDataSource
        collctionView.delegate = self
        // Do any additional setup after loading the view.
        //        store.fetchInterstingPhotos()
        updateDataSource()
        store.fetchInterstingPhotos{
            (photoResult) in
            
//            switch photoResult{
//            case let .success(photos):
//                print("Successfully found \(photos.count) photos.")
////                if let firstPhoto = photos.first {
////                    self.updateImageView(for: firstPhoto)
////                }
//                self.photoDataSource.photos = photos
//            case let .failure(error):
//                print("Error fetching interesting photos: \(error)")
//                self.photoDataSource.photos.removeAll()
//            }
//            self.collctionView.reloadSections(IndexSet(integer: 0))
            self.updateDataSource()
        }
        
    }
    
//    func updateImageView(for photo: Photo){
//        store.fetchImage(for: photo){
//            (imageResult) in
//
//            switch imageResult{
//            case let .success(image):
//                self.imageView.image = image
//            case let .failure(error):
//                print("Error downloading image: \(error)")
//            }
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImage(for: photo){
            (result) in
            
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
                  case let .success(image) = result else{
                      return
                  }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            if let cell = self.collctionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell{
                cell.update(displaying: image)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto"?:
            if let selectedIndexPath =
                collctionView.indexPathsForSelectedItems?.first {

                let photo = photoDataSource.photos[selectedIndexPath.row]

                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    private func updateDataSource(){
        store.fetchAllPhotos{
            (photoResult) in
            
            switch photoResult{
            case let .success(photos):
                self.photoDataSource.photos = photos
            case .failure:
                self.photoDataSource.photos.removeAll()
            }
            self.collctionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
}

