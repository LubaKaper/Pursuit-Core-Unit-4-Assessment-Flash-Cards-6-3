//
//  CardCell.swift
//  Unit4Assessment
//
//  Created by Liubov Kaper  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    private var currentCard: Card!
    
    private var isShowingAnswer = false
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
    
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
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
        label.font = UIFont.preferredFont(forTextStyle: .title2)
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
        //print("button was pressed for article \(currentArticle.title)")
        
        // step 3 of custom delegate
        // delegate?.didSelectMoreButton(self, article: currentArticle)
    }
    
    private func commonInit() {
        setupMoreButtonConstraints()
        setupQuestionLabelConstraints()
        setupAnswerLAbelConstraints()
        questionLablel.isUserInteractionEnabled = true
        addGestureRecognizer(longPressGesture)
    }
    
    private func setupMoreButtonConstraints() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 44),
            moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor)
        ])
    }
    
    private func setupQuestionLabelConstraints() {
        addSubview(questionLablel)
        questionLablel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLablel.leadingAnchor.constraint(equalTo: leadingAnchor),
            questionLablel.trailingAnchor.constraint(equalTo: trailingAnchor),
            questionLablel.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            questionLablel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupAnswerLAbelConstraints() {
        addSubview(answerLabel)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            answerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    public func configureCell(for savedCard: Card) {
        currentCard = savedCard
        questionLablel.text = savedCard.quizTitle
    }
    
}
