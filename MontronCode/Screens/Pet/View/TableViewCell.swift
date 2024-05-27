//
//  PetViewCell.swift
//  MontronCode
//
//  Created by Rashika Dube on 27/05/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!

    // MARK: - Lifecycle Methods
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            // Configure the view for the selected state
        }
        
        // MARK: - Configuration Methods
        
        func configure(with model: PetModel) {
            petNameLabel.text = model.title
        }
        
        func configure(with imageUrl: String) {
            petImageView.loadImage(from: imageUrl)
        }
    }
