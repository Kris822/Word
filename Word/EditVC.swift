//
//  EditVC.swift
//  Word
//
//  Created by Lee, Christopher on 10/23/21.
//

import UIKit
import CoreData

class EditVC: UIViewController {
    
    var media: [NSManagedObject] = []
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    func saveItem(title: String, password: String) {
        let context = AppDelegate.cdContext
        if let entity = NSEntityDescription.entity(forEntityName: "Entry", in: context) {
            let entry = NSManagedObject(entity: entity, insertInto: context)
            entry.setValue(title, forKeyPath: "title")
            entry.setValue(password, forKeyPath: "password")
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save the item. \(error), \(error.userInfo)")
            }
        }
    }
    
    
    
    
    @IBAction func onCancel(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
    
    
    @IBAction func onSave(_ sender: Any) {
        if let title = titleField?.text, let password = passwordField?.text {
            saveItem(title: title, password: password)
        }
        presentingViewController?.dismiss(animated: true)
    }
    
    
}

