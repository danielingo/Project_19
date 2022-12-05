//
//  SetTableViewCell.swift
//  Project_19
//
//  Created by Kirtana Mogili on 9/28/22.
//

import Foundation
import UIKit

class SetTableViewCell: UITableViewCell {
    @IBOutlet weak var setTitle: UILabel!
    @IBOutlet weak var setDate: UILabel!
    @IBOutlet weak var setImage: UIImageView!
    
    internal var aspectConstraint : NSLayoutConstraint? {
            didSet {
                if oldValue != nil {
                    setImage.removeConstraint(oldValue!)
                }
                if aspectConstraint != nil {
                    setImage.addConstraint(aspectConstraint!)
                }
            }
        }
    override func prepareForReuse() {
            super.prepareForReuse()
            aspectConstraint = nil
        }
    func setPostedImage(image : UIImage) {

            let aspect = image.size.width / image.size.height

        aspectConstraint = NSLayoutConstraint(item: setImage!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: setImage, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 0.0)

            setImage.image = image
        }
}
