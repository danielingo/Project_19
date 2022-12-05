//
//  TagDataSource.swift
//  Project_19
//
//  Created by Natasha Bohra on 11/8/22.
//

import Foundation
import UIKit

class TagDataSource: NSObject {
  // MARK: - Properties
  var tags = [
    "Bubblegum",
    "Buttercup",
    "Indigo",
    "Lavender",
    "Magenta",
    "Navy",
    "Orange",
    "Oxblood",
    "Periwinkle",
    "Poppy",
    "Purple",
    "Seafoam",
    "Sky",
    "Tan",
    "Teal",
    "Yellow"
  ]

  var selectedTag: String? {
    didSet {
      if let selectedTag = selectedTag,
        let index = tags.firstIndex(of: selectedTag) {
        selectedTagIndex = index
      }
    }
  }

  var selectedTagIndex: Int?

  // MARK: - Datasource Methods
  func selectTag(at indexPath: IndexPath) {
    selectedTag = tags[indexPath.row]
  }

  func numberOfTags() -> Int {
    tags.count
  }

  func tagName(at indexPath: IndexPath) -> String {
    tags[indexPath.row]
  }
}

