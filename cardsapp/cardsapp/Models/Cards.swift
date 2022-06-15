//
//  Cards.swift
//  cardsapp
//
//  Created by admin on 6/10/22.
//

import Foundation
import UIKit


struct Media: Decodable{
    public let image: String
    
    enum CodingKeys: String, CodingKey{
        case image
    }
}

struct Cards: Decodable{
    public var cards: [Media]?
    
    enum CodingKeys: String, CodingKey {
            case cards
    }
    
    
}


