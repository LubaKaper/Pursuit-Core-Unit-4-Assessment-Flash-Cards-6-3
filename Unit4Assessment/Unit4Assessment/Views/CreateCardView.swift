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
    
    public lazy var firstFactAnswer: UITableView = {
        let textView = UITableView()
        return textView
    }()
    
    public lazy var secondFactAnswer: UITableView = {
           let textView = UITableView()
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

}
