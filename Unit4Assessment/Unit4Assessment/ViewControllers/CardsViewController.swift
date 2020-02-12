//
//  CardsViewController.swift
//  Unit4Assessment
//
//  Created by Liubov Kaper  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CardsViewController: UIViewController {
    
    public var dataPersistance: DataPersistence<Card>!
    
    
    private let cardView = CardsView()
    
    override func loadView() {
        view = cardView
        
    }
    
    
    
    private var savedCards = [Card]() {
        didSet {
            print(savedCards.count)
            cardView.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSavedCards()

        cardView.collectionView.register(CardCell.self, forCellWithReuseIdentifier: "cardCell")
        
        cardView.collectionView.dataSource = self
        cardView.collectionView.delegate = self

        view.backgroundColor = .yellow
    }
    
    
    
    private func fetchSavedCards() {
        do {
        savedCards = try dataPersistance.loadItems()
        } catch {
           print("error saving cards \(error)")
        }
        
        
    }
    

   
}

extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardCell else {
            fatalError("could not downcast to CardCell")
        }
        let savedCard = savedCards[indexPath.row]
        cell.backgroundColor = .systemPink
        
        cell.configureCell(for: savedCard)
        return cell
    }
    
    
}
extension CardsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}

extension CardsViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchSavedCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchSavedCards()
    }
    
    
}
