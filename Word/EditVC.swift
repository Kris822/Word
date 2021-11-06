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
    
    func passwordStrength(password: String) -> Int{
        var strength = 0
        var symbolBool = false
        var numberBool = false
        
        if password.count > 10{
            strength += 1
        }
        
        if password.lowercased() != password && password.uppercased() != password{
            strength += 1
        }
        
        for char in password{
            if char.isSymbol{
                symbolBool = true
            }
            
            if char.isNumber{
                numberBool = true
            }
        }
        
        if symbolBool == true{
            strength += 1
        }
        if numberBool == true{
            strength += 1
        }
        return strength
    }
    
    func deletionAlert(completion: @escaping (Bool) -> Void) {
        let alertMsg = "Your password is very weak! Would you like us to auto-generate your password for you?"
        let alert = UIAlertController(title: "Warning", message: alertMsg, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Auto-Generate New password", style: .destructive, handler: { action in
            completion(true)
        })
        let cancelAction = UIAlertAction(title: "Keep Password", style: .destructive, handler: { action in
            completion(false)
        })
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        /*alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)*/
        
        present(alert, animated: true)
    }
    
    func saveItem(title: String, password: String, strength: Int) {
        let context = AppDelegate.cdContext
        if let entity = NSEntityDescription.entity(forEntityName: "Entry", in: context) {
            let entry = NSManagedObject(entity: entity, insertInto: context)
            entry.setValue(title, forKeyPath: "title")
            entry.setValue(password, forKeyPath: "password")
            
            print(password)
            
            let strength = passwordStrength(password: password)
            entry.setValue(strength, forKey: "strength")
       
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save the item. \(error), \(error.userInfo)")
            }
        }
    }
    
    
    
    
    @IBAction func onCancel(_ sender: Any) {
        //presentingViewController?.dismiss(animated: true)
    }
    
    func randomString() -> String{
       return "MyNameIsDave123@"
    }
    
    
    @IBAction func onSave(_ sender: Any) {
        
        if let title = titleField?.text, let password = passwordField?.text{
           
            let strength = passwordStrength(password: password)
            if strength < 3{
                
                deletionAlert(completion: {deleteAlert in
                    if deleteAlert{
                        let newPassword = self.randomString()
                        self.saveItem(title: title, password: newPassword, strength: strength)
                        
                        self.performSegue(withIdentifier: "windSegue", sender: self)
                    }
                    else{
                        self.saveItem(title: title, password: password, strength: strength)
                        self.performSegue(withIdentifier: "windSegue", sender: self)
                    }
                    
                    
                })

            }
            else{
                saveItem(title: title, password: password, strength: strength)
                performSegue(withIdentifier: "windSegue", sender: self)
            }
            
            /*let password = self.randomString()
            self.saveItem(title: title, password: password, strength: strength)*/
            
            //saveItem(title: title, password: password, strength: strength)
        }
        
        //presentingViewController?.dismiss(animated: true)
        
    }
    
    
}

