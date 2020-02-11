//
//  CreateCardView.swift
//  Unit4Assessment
//
//  Created by Liubov Kaper  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateCardView: UIView {
    
    public lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter question here"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    public lazy var firstFactAnswer: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray
        textView.text = "enter first quiz fact"
    
        return textView
    }()
    
    public lazy var secondFactAnswer: UITextView = {
           let textView = UITextView()
        textView.backgroundColor = .systemGray
        textView.text = "enter second quiz fact"
           return textView
       }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupTextFieldConstraints()
        setupfirstAnswerTextViewConstrains()
        setupSecondAnswerTextViewConstrains()
    }
    
    private func setupTextFieldConstraints() {
        addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupfirstAnswerTextViewConstrains() {
        addSubview(firstFactAnswer)
        firstFactAnswer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstFactAnswer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            firstFactAnswer.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            firstFactAnswer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            firstFactAnswer.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupSecondAnswerTextViewConstrains() {
        addSubview(secondFactAnswer)
        secondFactAnswer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondFactAnswer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            secondFactAnswer.topAnchor.constraint(equalTo: firstFactAnswer.bottomAnchor, constant: 15),
            secondFactAnswer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            secondFactAnswer.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

}
