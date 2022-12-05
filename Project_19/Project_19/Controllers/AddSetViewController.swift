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
    var newTitle = "" {
        didSet {
            nameTextField.text = newTitle
        }
    }
    
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var tagLabel: UILabel!
    
    override func viewDidLoad() {
        tag = "Bubblegum"
        newTitle = "set name here"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("DDDDDDD")
        if segue.identifier == "PickTag",
           let tagPickerViewController = segue.destination as? TagPickerViewController {
            print("EEEEEEEE")
            tagPickerViewController.tagDataSource.selectedTag = tag
            print("FFFFFFF")
        } else if segue.identifier == "showNewARView",
           let ARViewVC = segue.destination as? ARViewController {
            print("GGGGGGG")
            if let name = nameTextField.text, !name.isEmpty {
                print("HHHHHHHH")
                newTitle = name
                print("Title: ", newTitle)
                ARViewVC.title = newTitle
                print("IIIIIIIII")
            }
        }
        print("JJJJJJJJJ")
    }
    
}

extension AddSetViewController {
    
//    @IBAction func importFromUserFiles(_ sender: Any) {
//        let controller = UIDocumentPickerViewController(
//            documentTypes: ["public.3d-content"], // only want user to select 3D models
//            in: .import // mode is import file
//        )
//        controller.delegate = self
//        if #available(iOS 11.0, *) {
//            controller.allowsMultipleSelection = false
//        }
//    }
    
    @IBAction func unwindFromARView(segue: UIStoryboardSegue) {
        if let ARViewVC = segue.source as? ARViewController {
            print(ARViewVC.title!)
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func unwindWithSelectedTag(segue: UIStoryboardSegue) {
        if let tagPickerViewController = segue.source as? TagPickerViewController,
           let selectedTag = tagPickerViewController.tagDataSource.selectedTag {
            tag = selectedTag
        }
    }
    
}
