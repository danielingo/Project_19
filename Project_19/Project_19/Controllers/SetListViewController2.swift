//
//  SetListViewController2.swift
//  Project_19
//
//  Created by Kirtana Mogili on 9/28/22.
//

import Foundation
import UIKit
import os

class SetListViewController2: UITableViewController {
//    @IBOutlet weak var tableView: UITableView!
    
    let setList = Set.sampleData
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34, weight: .bold)]
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewController,
           let indexPath = tableView.indexPathForSelectedRow {
                destination.selectedSet = setList[indexPath.row]
        }
    }
    
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
        cell.setImage = nil
        
        return cell
    }
    
}
