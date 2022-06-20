//
//  DetailCardViewController.swift
//  cardsapp
//
//  Created by admin on 6/19/22.
//

import UIKit

class DetailCardViewController: UIViewController {
    //var cardImageView = UIImageView
    var image: String = ""
    
    @IBOutlet weak var cardIDImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var cards: Media?

    var selectedCard: Media?
    /*
    if segue.identifier == "goToCardDetail"{
        _ = segue.destination as! DetailCardViewController
        
        //selectedCard == Cards.init(cards: [Media])}
    }*/
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        performSegue(withIdentifier: "goToCardDetail", sender: nil)
        if segue.identifier == "goToCardDetail"{
            let cardDetailImg = segue.destination as? DetailCardViewController
            cardDetailImg?.image = selectedCard?.image ?? ":)"
            
        }
    
        
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
