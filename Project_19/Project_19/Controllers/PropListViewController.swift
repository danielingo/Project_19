//
//  PropListViewController.swift
//  Project_19
//
//  Created by Linsey Chen on 12/4/22.
//
import Foundation
import UIKit
import os
import FirebaseFirestore
import Firebase

class PropListViewController: UITableViewController {
//    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameTextField : UITextField!
    
    func setupFirebase() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        
    }
    
    func checkFirebase() -> Bool {
        if FirebaseApp.app() != nil {
            print("Firebase instance recognized")
            return true
        } else {
            print("No Firebase instance recognized")
            return false
        }
    }
    
    
    let propList = Set.sampleData
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34, weight: .bold)]
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let ARViewVC = segue.destination as? ARViewController else { return }
//        if let name = nameTextField.text, !name.isEmpty {
//            ARViewVC.title = name
//        }
//    }
    
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         print("AAAAAAAAA")
//         if segue.identifier == "showExistingARView",
//            let PListVC = segue.destination as? PropList, let indexPath = tableView.indexPathForSelectedRow {
//             print("BBBBBBB")
//             print("Selected Set: ", indexPath.row)
// //            ARViewVC.selectedSet = setList[indexPath.row]
//         }
//         print("CCCCCCCC")
//     }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // segue = showExistingARView
//        if let ARViewVC = segue.destination as? ARViewController,
//           let indexPath = tableView.indexPathForSelectedRow {
//                ARViewVC.selectedSet = setList[indexPath.row]
//        }
//    }
    
//    @IBAction func unwindDone
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Prop Table View Cell", for: indexPath) as! SetTableViewCell
        
        
//        cell.setPostedImage(image: image!)
        let set = propList[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        cell.setTitle.text = set.title
        cell.setDate.text = dateFormatter.string(from: set.date)
        cell.setPostedImage(image: set.image)
        
        return cell
    }
    
    func writeData(){
        
        print("YEEEHAW1")
        if let name = self.nameTextField.text, !name.isEmpty {
            print("YEEEHAW2")
            saveData(text: name)
            print("YEEHAW3")
        }
        print("YEEEEEHAW4")
    }
    
    func saveData(text: String) {
        
        if !checkFirebase() {
            setupFirebase()
        }
        
        let db = Firestore.firestore()
        
        let docRef = db.document("MySets/\(text)")
        docRef.setData(["name": text, "createdDate": Date(), "editedDate": Date()])
    }
    
}

extension PropListViewController {
    
    @IBAction func cancelToParentView(_ segue: UIStoryboardSegue) {
        print(segue.identifier!)
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        print("DONE BUTTON CLICKED")
        
//        writeData()
        
//        self.navigationController?.popViewController(animated: true)
//        self.navigationController?.popToRootViewController(animated: true)
//        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
}
