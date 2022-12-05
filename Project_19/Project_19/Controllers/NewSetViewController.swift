//
//  NewSetViewController.swift
//  Project_19
//
//  Created by Natasha Bohra on 10/13/22.
//

import Foundation
import UIKit
import FirebaseFirestore

class NewSetViewController: UITableView {
    
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var tagLabel: UILabel!
    
    var categoryTag = "" {
        didSet {
            tagLabel.text = categoryTag
        }
    }
    
    let db = Firestore.firestore()
    
    @IBAction func DoneButtonClicked(_ sender: Any) {
        print("Create New Set --> Done Button Clicked")
        
        if let name = self.nameTextField.text, !name.isEmpty {
            saveData(text: name)
        }
    }
    
    @IBAction func CancelButtonClicked(_ sender: Any) {
        print("Create New Set --> Cancel Button Clicked")
        
        self.inputAccessoryViewController?.navigationController?.popViewController(animated: true)
    }
    
//    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
//        if let name = textField.text, !name.isEmpty {
//            saveData(text: name)
//
//        }
//        return true
//    }
    
    func saveData(text: String) {
        let docRef = db.document("MySets/\(text)")
        docRef.setData(["name": text, "createdDate": Date(), "editedDate": Date()])
    }
    
//    override func viewDidLoad() {
//        categoryTag = "Bubblegum"
//    }
    
}
