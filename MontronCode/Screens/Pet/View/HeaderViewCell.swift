//
//  PetViewCell.swift
//  MontronCode
//
//  Created by Rashika Dube on 27/05/24.
//

import UIKit

class HeaderViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    
    // MARK: - Lifecycle Methods
        
        override func awakeFromNib() {
            super.awakeFromNib()
            setupUI()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        
        // MARK: - Private Methods
        
        private func setupUI() {
            setupBorder(for: lineView, withWidth: 2, andColor: UIColor.lightGray.cgColor)
        }

        private func setupBorder(for view: UIView, withWidth borderWidth: CGFloat, andColor borderColor: CGColor) {
            view.layer.borderWidth = borderWidth
            view.layer.borderColor = borderColor
        }
    }
