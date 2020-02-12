//
//  SearchCardsCellCell.swift
//  Unit4Assessment
//
//  Created by Liubov Kaper  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol SavedCardCellDelegate: AnyObject {
    func didSelectAddButton(_ savedCardCell: SearchCardsCellCell, card: Card)
}

class SearchCardsCellCell: UICollectionViewCell {
    
    weak var delegate: SavedCardCellDelegate?
    
    private var currentCard: Card!
    
   
    
    
    
    private var isShowingAnswer = false
       
       private lazy var longPressGesture: UILongPressGestureRecognizer = {
           let gesture = UILongPressGestureRecognizer()
           gesture.addTarget(self, action: #selector(didLongPress(_:)))
           return gesture
       }()
       
       
       public lazy var addButton: UIButton = {
           let button = UIButton()
           button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
           button.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
           return button
       }()
       
       public lazy var questionLablel: UILabel = {
           let label = UILabel()
           label.numberOfLines = 2
           label.font = UIFont.preferredFont(forTextStyle: .title2)
           label.text = "Question"
           //label.alpha = 0
           
           return label
       }()
       
       public lazy var answerLabel: UILabel = {
           let label = UILabel()
           label.numberOfLines = 0
           label.font = UIFont.preferredFont(forTextStyle: .title1)
           label.text = "Answer"
           
           label.alpha = 0
           
           return label
       }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           commonInit()
       }
    
//    @objc func saveButtonPressed(_ sender: UIButton) {
//         print(" button pressed")
//           guard let card = currentCard else { return }
//           do {
//               try dataPersistance.createItem(card)
//               print("card created")
//           } catch {
//               print("error saving card \(error)")
//           }
//       }
       
       @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
           // guard let currentArticle = currentArticle else {return}
           if gesture.state == .began || gesture.state == .changed {
               print("Long pressed")
               return
           }
           isShowingAnswer.toggle() // true -> false -> true
           self.animate()
       }
       
       private func animate() {
           let duration: Double = 1.0 // seconds
           if isShowingAnswer {
               UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                   self.answerLabel.alpha = 1.0
                   self.questionLablel.alpha = 0.0
               }, completion: nil)
           } else {
               UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                   self.answerLabel.alpha = 0.0
                   self.questionLablel.alpha = 1.0
               }, completion: nil)
           }
       }
       
       @objc private func addButtonPressed(_ sender: UIButton) {
        print("button was pressed for article \(currentCard.quizTitle)")
           
           // step 3 of custom delegate
        delegate?.didSelectAddButton(self, card: currentCard)
       }
       
       private func commonInit() {
           setupMoreButtonConstraints()
           setupQuestionLabelConstraints()
           setupAnswerLAbelConstraints()
           questionLablel.isUserInteractionEnabled = true
           addGestureRecognizer(longPressGesture)
       }
       
       private func setupMoreButtonConstraints() {
           addSubview(addButton)
           addButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               addButton.topAnchor.constraint(equalTo: topAnchor),
               addButton.trailingAnchor.constraint(equalTo: trailingAnchor),
               addButton.heightAnchor.constraint(equalToConstant: 44),
               addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor)
           ])
       }
       
       private func setupQuestionLabelConstraints() {
           addSubview(questionLablel)
           questionLablel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               questionLablel.leadingAnchor.constraint(equalTo: leadingAnchor),
               questionLablel.trailingAnchor.constraint(equalTo: trailingAnchor),
               questionLablel.topAnchor.constraint(equalTo: addButton.bottomAnchor),
               questionLablel.bottomAnchor.constraint(equalTo: bottomAnchor)
           ])
       }
       
       private func setupAnswerLAbelConstraints() {
           addSubview(answerLabel)
           answerLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               answerLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor),
               answerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
               answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
               answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
           ])
       }
    
    public func configureCell(for card: Card) {
        currentCard = card
        questionLablel.text = card.quizTitle
       answerLabel.text = "1. \(card.facts.first ?? "")\n2. \(card.facts.last ?? "")"
    }
}
