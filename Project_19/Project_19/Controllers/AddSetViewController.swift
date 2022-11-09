//
//  AddSetViewController.swift
//  Project_19
//
//  Created by Natasha Bohra on 11/8/22.
//

import Foundation
import UIKit
import FirebaseFirestore

class AddSetViewController: UITableViewController {
    
    var tag = "" {
        didSet {
            tagLabel.text = tag
        }
    }
    
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var tagLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        tag = "Bubblegum"
    }
    
}

extension AddSetViewController {
    
    @IBAction func unwindWithSelectedTag(segue: UIStoryboardSegue) {
        
    }
    
}
