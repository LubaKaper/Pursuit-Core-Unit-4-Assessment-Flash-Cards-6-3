//
//  CreateCardViewController.swift
//  Unit4Assessment
//
//  Created by Liubov Kaper  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateCardViewController: UIViewController {
    
    public var dataPersistance: DataPersistence<Card>!
    
   // public var createdCard: CreatedCard?
    
    private let createCardView = CreateCardView()
    
    override func loadView() {
        view = createCardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createCardView.titleTextField.delegate = self
        createCardView.firstFactAnswer.delegate = self
        createCardView.secondFactAnswer.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(saveButtonPressed(_:)))
        view.backgroundColor = .systemBackground
    }
    
//    private func updateUI() {
//        if let card = createdCard {
//            createCardView.titleTextField.text = card.question
//            createCardView.firstFactAnswer.text = card.factOne
//            createCardView.secondFactAnswer.text = card.factTwo
//
//        }
//    }
    
    @objc func saveButtonPressed(_ sender: UIBarButtonItem) {
        print("button pressed")
        let cardObject = Card(quizTitle: createCardView.titleTextField.text ?? "", facts: [createCardView.firstFactAnswer.text,createCardView.secondFactAnswer.text])
        
        do {
            try dataPersistance.createItem(cardObject)
            print("card created")
        } catch {
            print("saving error: \(error)")
        }
         dismiss(animated: true, completion: nil)
    }

    

}
extension CreateCardViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // adding placeholder text to textView
        if createCardView.firstFactAnswer.text == "enter first quiz fact"{
        createCardView.firstFactAnswer.text = ""
        }
        if createCardView.secondFactAnswer.text == "enter second quiz fact"{
        createCardView.secondFactAnswer.text = ""
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if createCardView.firstFactAnswer.text == ""{
        createCardView.firstFactAnswer.text = "enter first quiz fact"
        }
        if createCardView.secondFactAnswer.text == ""{
        createCardView.secondFactAnswer.text = "enter second quiz fact"
        }
        textView.resignFirstResponder()
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        print(text)
//        if createCardView.firstFactAnswer.text == "\n" {
//            createCardView.firstFactAnswer.resignFirstResponder()
//        }
//        if createCardView.secondFactAnswer.text == "\n" {
//            createCardView.secondFactAnswer.resignFirstResponder()
//        }
//        return true
//    }
}
extension CreateCardViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
       // textField.resignFirstResponder()
    }
}
