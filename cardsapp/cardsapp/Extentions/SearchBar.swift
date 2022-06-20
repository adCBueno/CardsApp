
import Foundation
import UIKit
//import SVProgressHUD


extension ViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
               
        filteredCards = cards.filter({
            $0.suit.lowercased().prefix(searchText.count) == searchText.lowercased() ||
            $0.code.lowercased().prefix(searchText.count) == searchText.lowercased() ||
            $0.value.lowercased().prefix(searchText.count)  == searchText.lowercased() })
        
        collectionView.reloadData()

    }
    
}
