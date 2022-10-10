//
//  ViewController.swift
//  Project_19
//
//  Created by Daniel Ingo on 9/5/22.
//


// DON'T USE BUT IDK IF WILL BREAK IF REMOVED - Daniel

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    var selectedSet: Set!
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        ///let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        //arView.scene.anchors.append(boxAnchor)
    }
}
