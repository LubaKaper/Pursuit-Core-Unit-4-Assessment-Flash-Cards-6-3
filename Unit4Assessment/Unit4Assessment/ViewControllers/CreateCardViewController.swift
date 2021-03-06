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
        navigationItem.title = "Create Quiz"
        createCardView.titleTextField.delegate = self
        createCardView.firstFactAnswer.delegate = self
        createCardView.secondFactAnswer.delegate = self
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(saveButtonPressed(_:)))
        createButtonDisable()
        
        
        view.backgroundColor = .systemBackground
    }
    private func createButtonDisable() {
        if createCardView.firstFactAnswer.text == "enter first quiz fact" || createCardView.secondFactAnswer.text == "enter second quiz fact"  || createCardView.firstFactAnswer.text == "" || createCardView.secondFactAnswer.text == "" || createCardView.titleTextField.text?.isEmpty ?? true {
            
//            createCardView.firstFactAnswer.text.isEmpty || createCardView.secondFactAnswer.text.isEmpty || createCardView.titleTextField.text?.isEmpty ?? true {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
//        else {
//            navigationItem.rightBarButtonItem?.isEnabled = true
//        }
    }
    
    
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
        
        // this resigns keyboard after create button is pressed
        self.view.endEditing(true )
        
        emptyAllFields()
        self.showAlert(title: "Saved", message: "Created Quiz Card Was Saved!")
        createButtonDisable()
    }
    
    private func emptyAllFields() {
        createCardView.firstFactAnswer.text = "enter first quiz fact"
        createCardView.secondFactAnswer.text = "enter second quiz fact"
        createCardView.titleTextField.text? = ""
        
    }
    
    
    
}
extension CreateCardViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // adding placeholder text to textView
        // navigationItem.rightBarButtonItem?.isEnabled = true
        if createCardView.firstFactAnswer.text == "enter first quiz fact"{
            createCardView.firstFactAnswer.text = ""
        }
        if createCardView.secondFactAnswer.text == "enter second quiz fact"{
            createCardView.secondFactAnswer.text = ""
        }
        
//        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if createCardView.firstFactAnswer.text == "" {
            createCardView.firstFactAnswer.text = "enter first quiz fact"
           
        }
        if createCardView.secondFactAnswer.text == ""{
            createCardView.secondFactAnswer.text = "enter second quiz fact"
            
        }
        
        navigationItem.rightBarButtonItem?.isEnabled = true

       // textView.resignFirstResponder()
        
        
    }
    
}

extension CreateCardViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // textField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateCardViewController {
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
       let okAction = UIAlertAction(title: "OK", style: .default, handler: completion)
       alertController.addAction(okAction)
       present(alertController, animated: true, completion: nil)
     
    }
}
