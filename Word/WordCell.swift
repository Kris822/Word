//
//  WordCell.swift
//  Word
//
//  Created by Lee, Christopher on 10/23/21.
//

import UIKit

class WordCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var subtitleCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with entry: Entry) {
        if let title = entry.value(forKey: "title") as? String,
           let password = entry.value(forKey: "password") as? String,
           let strength = entry.value(forKey: "strength") as? Int{
            
            titleCell?.text = title
            subtitleCell?.text = password
            
            let yellowGreen = UIColor(red: 198/255, green: 1, blue: 84/255, alpha: 1)
            
            if strength == 4{
                self.backgroundColor = UIColor.green
            }
            else if strength == 3{
                self.backgroundColor = yellowGreen
            }
            else if strength == 2{
                self.backgroundColor = UIColor.yellow
            }
            else if strength == 1{
                self.backgroundColor = UIColor.orange
            }
            else if strength == 0{
                self.backgroundColor = UIColor.red
            }
            else{
                self.backgroundColor = UIColor.black
            }
            
        }
    }
    
}
