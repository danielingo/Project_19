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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickTag",
           let tagPickerViewController = segue.destination as? TagPickerViewController {
            tagPickerViewController.tagDataSource.selectedTag = tag
        }
    }
    
}

extension AddSetViewController {
    
    @IBAction func unwindWithSelectedTag(segue: UIStoryboardSegue) {
        if let tagPickerViewController = segue.source as? TagPickerViewController,
           let selectedTag = tagPickerViewController.tagDataSource.selectedTag {
            tag = selectedTag
        }
    }
    
}
