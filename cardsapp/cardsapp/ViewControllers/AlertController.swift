//
//  AlertController.swift
//  cardsapp
//
//  Created by admin on 6/20/22.
//

import UIKit

class AlertController: UIAlertController {

    public func alertEmptyCards() {
        let alert = UIAlertController(title: "Error", message: "No cards shuffled", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
