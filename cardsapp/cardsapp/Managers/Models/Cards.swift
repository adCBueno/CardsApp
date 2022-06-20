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
    public let suit: String
    public let value: String
    public let code: String
    
    enum CodingKeys: String, CodingKey{
        case image
        case suit
        case value
        case code
    }
}

struct Cards: Decodable{
    //image
    public var cards: [Media]
    
    enum CodingKeys: String, CodingKey {
            case cards
    }
    
    
}


