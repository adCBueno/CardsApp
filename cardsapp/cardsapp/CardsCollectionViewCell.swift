//
//  CardsCollectionViewCell.swift
//  cardsapp
//
//  Created by admin on 6/10/22.
//

import UIKit

class CardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardsImageVIew: UIImageView!
    
    func setup(with cards: Cards){
        cardsImageVIew.image = cards.image
    }
}
