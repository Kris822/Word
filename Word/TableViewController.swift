//
//  ViewController.swift
//  Word
//
//  Created by Lee, Christopher on 10/23/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        self.title = "Word"

        self.registerTableViewCells()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    private func registerTableViewCells(){
        let textFieldCell = UINib(nibName: "WordCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "WordCell")
    }
    
    //override func tableView(_ tableView: UITableView, numberofRowsInSection section: Int) -> Int {
        
    //}
    
    
}

