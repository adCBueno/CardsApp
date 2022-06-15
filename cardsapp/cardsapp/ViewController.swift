import UIKit


class ViewController: UIViewController  {
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    @IBOutlet weak var CollectionViewCell_Cards: UICollectionViewCell!
    
    public let deckItem = "deckItem"
    public var cards: [Cards] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        let uiNib = UINib(nibName: "CardsCell", bundle: nil)
        collectionView.register(uiNib, forCellWithReuseIdentifier: deckItem)
    }
    @IBAction func shuffleBottom(_ sender: Any) {
        loadDeckId()
    }
}
func loadDeckId(){
    
    guard URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1") != nil else {
        print("Invalid URL")
        return}

    
    let urlStr = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"

    // guard cause url is optional, it could probably not work
    guard let url = URL(string: urlStr) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    NetworkManager.shared.get([Deck].self, from: url)
    {
        result in
        
        switch result {
            
        case .success(let deck):
            getCardsId(fromID: deckId)
            
        case .failure(let error):
            print(error)
                    
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
             print("OK")
         }))
        }
    }
    
    
    func getCardsId(fromID deckId: String){
        let finalDeckStr="https://deckofcardsapi.com/api/deck/\(deckId)/draw/?count=52"
        guard let finalDeckurl=URL(string : finalDeckStr) else{ return }
               
                
        NetworkManager.shared.get( GetCards.self, from: finalDeckurl )
        { result in
            
            switch result {
                
            case .success(let deck):
                self.cards = deck.cards
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
        cards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsCollectionViewCell", for: indexPath) as? CardsCollectionViewCell
            
        let card = cards[indexPath.row]
        if let imageURL = URL(string: Card.image){
            UIImageView.load(url: imageURL)
        }
        
        return cell!
            }
}

    
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 280)
    }
}

extension UIImageView {
    public func load(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func load(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        load(from: url, contentMode: mode)
    }
}


    
    
