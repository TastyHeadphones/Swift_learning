//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Magic Keegan on 10/5/21.
//

import UIKit

class ItemsViewController : UITableViewController{
    
    var itemStore : ItemStore!
    var imageStore : ImageStore!
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
//        tableView.rowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",for: indexPath) as! ItemCell
        let item = itemStore.allItems[indexPath.row]
        
//        cell.textLabel?.text = item.name
//        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        cell.nameLable.text = item.name
        cell.valueLabel.text = "$\(item.valueInDollars)"
        cell.serialNumberLabel.text = item.serialNumber
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = itemStore.allItems[indexPath.row]
            itemStore.removeItem(item)
            imageStore.deleteImage(forKey: item.itemKey)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "showItem":
            if let row = tableView.indexPathForSelectedRow?.row{
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    @IBAction func addNewItem(_ sender : UIBarButtonItem){
//        let lastRow = tableView.numberOfRows(inSection: 0)
//        let indexPath = IndexPath(row: lastRow, section: 0)
//
//        tableView.insertRows(at: [indexPath], with: .automatic)
        
        let newItem = itemStore.creatItem()
        
        if let index = itemStore.allItems.firstIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
//    @IBAction func toggleEditingMode(_ sender : UIButton){
//        if isEditing{
//            sender.setTitle("Edit", for : .normal)
//            setEditing(false, animated: true)
//        }
//        else{
//            sender.setTitle("Done", for: .normal)
//            setEditing(true, animated: true)
//        }
//    }
}
