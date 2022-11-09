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
        
        if indexPath.row == tagDataSource.selectedTagIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        // removes gray selection bkgrnd that appears by default
        tableView.deselectRow(at: indexPath, animated: true)
        
        // get prev selected tag and remove checkmark from the cell
        if let index = tagDataSource.selectedTagIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        // select the new tag in the data source
        tagDataSource.selectTag(at: indexPath)
        
        // mark new cell with checkmark
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        // trigger the segue manually
        performSegue(withIdentifier: "unwindTagSelect", sender: cell)
    }
}
