//
//  ItemStore.swift
//  LootLogger
//
//  Created by Magic Keegan on 10/7/21.
//

import UIKit

class ItemStore{
    
    var allItems = [Item]()
    
    let itemArchiveURL:URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("item.plist")
    }()
    
    @discardableResult func creatItem() -> Item{
        let newItem = Item(random : true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    init() {
        do {
            let data = try Data(contentsOf: itemArchiveURL)
            let unarchiver = PropertyListDecoder()
            let items = try unarchiver.decode([Item].self, from: data)
            allItems = items
        } catch  {
            print("Error reading in saved items: \(error)")
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
    }
//    init(){
//        for _ in 0..<5{
//            creatItem()
//        }
//
//    }
    
    func removeItem (_ item: Item){
        if let index = allItems.firstIndex(of: item){
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex:Int,to toIndex:Int){
        if fromIndex == toIndex{
            return
        }
        
        let moveItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        
        allItems.insert(moveItem, at: toIndex)
        
    }
    
    
    @objc func saveChanges() -> Bool{
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allItems)
            try data.write(to: itemArchiveURL, options: [.atomic])
            print("Saved all of the items \(itemArchiveURL)")
            return true
        }catch  let encodingError{
            print("Error encoding allItems: \(encodingError)")
        }
       
        
        return false
    }
}
