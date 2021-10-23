//
//  ViewController.swift
//  Word
//
//  Created by Lee, Christopher on 10/23/21.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var media: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Word"

        self.registerTableViewCells()
        readData()
    }
    
    private func registerTableViewCells(){
        let textFieldCell = UINib(nibName: "WordCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "WordCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell") as? WordCell else {
            fatalError("WordCell")
        }
        
        if let entry = media[indexPath.row] as? Entry {
            cell.update(with: entry)
        }
        
        cell.imageCell.image = UIImage(named: "w")
        
            
        
        return cell
    }
    
    
    func readData() {
        let context = AppDelegate.cdContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entry")
        do {
            media = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch requested item. \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
    
    /*func deleteItem(entry: Entry) {
        let context = AppDelegate.cdContext
        if let _ = media.firstIndex(of: entry)  {
            context.delete(entry)
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not delete the item. \(error), \(error.userInfo)")
            }
        }
        readData()
    }*/
    
    // MARK: - Actions
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        readData()
        tableView.reloadData()
    }

    }
    
    //override func tableView(_ tableView: UITableView, numberofRowsInSection section: Int) -> Int {
        
    //}

