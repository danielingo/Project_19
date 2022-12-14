//
//  SetListViewController2.swift
//  Project_19
//
//  Created by Kirtana Mogili on 9/28/22.
//

import Foundation
import UIKit
import os
import FirebaseFirestore
import Firebase

class SetListViewController2: UITableViewController {
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
    
    
    let setList = Set.sampleData
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showExistingARView",
           let ARViewVC = segue.destination as? ARViewController, let indexPath = tableView.indexPathForSelectedRow {
            print("Selected Set: ", indexPath.row)
        }
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // segue = showExistingARView
//        if let ARViewVC = segue.destination as? ARViewController,
//           let indexPath = tableView.indexPathForSelectedRow {
//                ARViewVC.selectedSet = setList[indexPath.row]
//        }
//    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Set Table View Cell", for: indexPath) as! SetTableViewCell
        
        
        let set = setList[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        cell.setTitle.text = set.title
        cell.setDate.text = dateFormatter.string(from: set.date)
        cell.setPostedImage(image: set.image)
        
        return cell
    }
    
    func writeData(){
        
        if let name = self.nameTextField.text, !name.isEmpty {
            saveData(text: name)
        }
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

extension SetListViewController2 {
    
    @IBAction func cancelToParentView(_ segue: UIStoryboardSegue) {
        print(segue.identifier!)
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        print("Done")
    }
    
    @IBAction func doneToARView(_ segue: UIStoryboardSegue) {
        print("Create New Set --> Done Button Clicked")
        
    }
}
