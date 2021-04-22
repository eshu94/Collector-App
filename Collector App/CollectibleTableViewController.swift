//
//  CollectibleTableViewController.swift
//  Collector App
//
//  Created by ESHITA on 07/10/19.
//  Copyright © 2019 ESHITA. All rights reserved.
//

import UIKit

class CollectibleTableViewController: UITableViewController {
    
    var collectibleList : [CollectibleData] = []
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        //tableView.backgroundColor = UIColor.init(red: 0.8353, green: 0.9059, blue: 0.9294, alpha: 0.5)
        getCollectibles()
    }
    
    func getCollectibles(){
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let collectible = try? context.fetch(CollectibleData.fetchRequest()){
                if let theCollectible = collectible as? [CollectibleData]{
                    collectibleList = theCollectible
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return collectibleList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let collectibles = collectibleList[indexPath.row]
        
        cell.textLabel?.text = collectibles.title
        if let dataImage = collectibles.image {
            cell.imageView?.image = UIImage(data: dataImage)
        }
        // cell.backgroundColor = UIColor.init(red: 0.5765, green: 0.7333, blue: 0.7569, alpha: 0.5)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let collectiblesDelete = collectibleList[indexPath.row]
                context.delete(collectiblesDelete)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getCollectibles()
            }
        }
    }
    
}
