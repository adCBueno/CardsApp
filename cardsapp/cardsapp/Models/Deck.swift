//
//  Deck.swift
//  cardsapp
//
//  Created by admin on 6/14/22.
//

import Foundation
import UIKit


public struct Deck: Decodable{
    public var success: Bool
    public var deckId: String
    
    enum CodingKeys: String, CodingKey {
            case success
            case deckId = "deck_id"
        }
}
