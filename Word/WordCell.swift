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
           let password = entry.value(forKey: "password") as? String{
            
            titleCell?.text = title
            subtitleCell?.text = password
        }
    }
    
}
