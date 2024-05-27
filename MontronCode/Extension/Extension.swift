//
//  Extension.swift
//  MontronCode
//
//  Created by Rashika Dube on 27/05/24.
//

import Foundation
import UIKit

// MARK: - Extension for UIImageView

extension UIImageView {
    
    func loadImage(from urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
    
// MARK: - Function for Getting Office Hours

func isOfficeHours() -> Bool {
    let now = Date()
    
    let officeStart = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: now)!
    let officeEnd = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: now)!
    
    return now >= officeStart && now < officeEnd
}
