//
//  SearchCardsViewController.swift
//  Unit4Assessment
//
//  Created by Liubov Kaper  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchCardsViewController: UIViewController {
    
    public var dataPersistance: DataPersistence<Card>!
    
    var card: Card?
    var cards = [Card]() {
        didSet {
            searchCardView.collectionView.reloadData()
        }
    }
    
    private let searchCardView = SearchCardsView()
    
    override func loadView() {
        view = searchCardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchCardView.collectionView.register(SearchCardsCellCell.self, forCellWithReuseIdentifier: "searchCardCell")
        
        searchCardView.collectionView.dataSource = self
        searchCardView.collectionView.delegate = self

        //searchCardView.collectionView.

        view.backgroundColor = .red
        loadData()
    }
    
    func loadData() {
        cards = Card.getCards()
    }
    


}

extension SearchCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCardCell", for: indexPath) as? SearchCardsCellCell else {
            fatalError("could not downcast from SearchCardsCell")
        }
        let card = cards[indexPath.row]
        cell.configureCell(for: card)
        cell.backgroundColor = .systemOrange
        cell.delegate = self
        return cell
    }
    
    
}

extension SearchCardsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}

extension SearchCardsViewController: SavedCardCellDelegate {
    func didSelectAddButton(_ savedCardCell: SearchCardsCellCell, card: Card) {
        
        if dataPersistance.hasItemBeenSaved(card) {
            self.showAlert(title: "Card Was Already Saved", message: "Choose another card")
//            if let index = try? dataPersistance.loadItems().firstIndex(of: card) {
//                do {
//                    try dataPersistance.deleteItem(at: index)
//                } catch {
//                    print("error deleting article \(error)")
//                }
//            }
        } else {
        
        do {
            try dataPersistance.createItem(card)
            print("card created")
            self.showAlert(title: "Saved", message: "Quiz card was saved")
        } catch {
            print("error saving card \(error)")
        }
        }
        print(card.quizTitle)

    }
    
    
    }
    
    
extension SearchCardsViewController {
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
       let okAction = UIAlertAction(title: "OK", style: .default, handler: completion)
       alertController.addAction(okAction)
       present(alertController, animated: true, completion: nil)
     
    }
}

