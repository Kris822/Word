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
    
    
    func deletionAlert(title: String, completion: @escaping (UIAlertAction) -> Void) {
        let alertMsg = "Are you sure you want to delete \(title)?"
        let alert = UIAlertController(title: "Warning", message: alertMsg, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
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
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let entry = media[indexPath.row] as? Entry, let title = entry.title {
                deletionAlert(title: title, completion: { _ in
                    self.deleteItem(entry: entry)
                })
            }
        }
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
    
    func deleteItem(entry: Entry) {
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
    }
    
    // MARK: - Actions
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        readData()
        tableView.reloadData()
    }

    @IBAction func onEditButton(_ sender: UIBarButtonItem) {
        setEditing(!isEditing, animated: true)
    }
}
    
    //override func tableView(_ tableView: UITableView, numberofRowsInSection section: Int) -> Int {
        
    //}

