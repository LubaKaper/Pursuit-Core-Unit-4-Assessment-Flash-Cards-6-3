//
//  CardsViewController.swift
//  Unit4Assessment
//
//  Created by Liubov Kaper  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    private let cardView = CardsView()
    
    override func loadView() {
        view = cardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.collectionView.register(CardCell.self, forCellWithReuseIdentifier: "cardCell")
        
        cardView.collectionView.dataSource = self
        cardView.collectionView.delegate = self

        view.backgroundColor = .yellow
    }
    

   
}

extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath)
        cell.backgroundColor = .systemPink
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
