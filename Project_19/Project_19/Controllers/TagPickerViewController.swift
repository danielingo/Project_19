//
//  TagPickerViewController.swift
//  Project_19
//
//  Created by Natasha Bohra on 11/8/22.
//

import Foundation
import UIKit

class TagPickerViewController: UITableViewController {
    
    let tagDataSource = TagDataSource()
    
}

extension TagPickerViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        tagDataSource.numberOfTags()
    }
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
        cell.textLabel?.text = tagDataSource.tagName(at: indexPath)
        
        return cell
    }
}
