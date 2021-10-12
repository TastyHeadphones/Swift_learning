//
//  ItemStore.swift
//  LootLogger
//
//  Created by Magic Keegan on 10/7/21.
//

import UIKit

class ItemStore{
    
    var allItems = [Item]()
    
    @discardableResult func creatItem() -> Item{
        let newItem = Item(random : true)
        
        allItems.append(newItem)
        
        return newItem
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
}
