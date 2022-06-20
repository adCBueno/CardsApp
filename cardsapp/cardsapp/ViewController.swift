import UIKit


class ViewController: UIViewController  {
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    @IBOutlet weak var searchBar: UISearchBar!
    
    public let deckCellIdentifier = "CardCollectionViewCellTwo"
    var cards: [Media] = []
    var filteredCards: [Media] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        
        let uiNib = UINib(nibName: "CardCollectionViewCellTwo", bundle: nil)
        collectionView.register(uiNib, forCellWithReuseIdentifier: deckCellIdentifier)
        
    }
    
    @IBAction func shuffleBottom(_ sender: Any) {
        loadDeck()
    }



func loadDeck(){
    
    let urlStr = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"

    // guard cause url is optional, it could probably not work
    guard let url = URL(string: urlStr) else { return print("Invalid URL") }
    
    NetworkManager.shared.get(Deck.self, from: url){ result in
        
        switch result {
        case .success(let deck):
            self.getCardsfromDeckId(fromDeckId: deck.deckId)
            
        case .failure(let error):
            print(error)
                    
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
             print("OK")
         }))
        }
    }
}
    
   public func getCardsfromDeckId(fromDeckId deckId: String){
        
        let finalDeckStr="https://deckofcardsapi.com/api/deck/\(deckId)/draw/?count=52"
        guard let finalDeckurl=URL(string : finalDeckStr) else{ return }
               
                
        NetworkManager.shared.get( Cards.self, from: finalDeckurl ) { result in
            
            switch result {
                
            case .success(let cards):
                self.cards = cards.cards
                self.collectionView.reloadData()

            case .failure(let error):
                print(error)
                
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    print("OK")
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
     }
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard filteredCards.isEmpty else {
            return filteredCards.count
        }
        return cards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCellTwo", for: indexPath) as? CardCollectionViewCellTwo else {return UICollectionViewCell()}
        
        let card: Media
                
        if filteredCards.isEmpty { card = cards[indexPath.row] }
        else { card = filteredCards[indexPath.row] }
        
        cell.cardImageView.image = readUrl(urlStr: card.image)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let DetailCard = DetailCardViewController()
           
            if filteredCards.isEmpty {
                DetailCard.cards = cards[indexPath.row]
            } else {
                DetailCard.cards = filteredCards[indexPath.row]
            }
            
            showDetailViewController(DetailCard, sender: nil)
        }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4
        let height = collectionView.frame.width / 3
        return CGSize(width: width, height: height)
        
    }
}

extension UIImageView {

    func load(url: URL) {

        DispatchQueue.global().async { [weak self] in

            if let data = try? Data(contentsOf: url) {

                if let image = UIImage(data: data) {

                    DispatchQueue.main.async {

                        self?.image = image

                    }

                }

            }

        }

    }

}
    

func readUrl(urlStr: String) -> UIImage? {
        let url = URL(string: urlStr)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        
        return image
    }


