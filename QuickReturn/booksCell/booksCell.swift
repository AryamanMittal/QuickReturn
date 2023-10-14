//
//  booksCell.swift
//  QuickReturn
//
//  Created by aryaman mittal on 12/10/23.
//

import UIKit

class booksCell: UITableViewCell {

    @IBOutlet weak var nameBookLabel: UILabel!
    
    @IBOutlet weak var availableButtonAsLabel: UIButton!
    @IBOutlet weak var pagesLabel: UILabel!
    
    @IBOutlet weak var authorOfBook: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
