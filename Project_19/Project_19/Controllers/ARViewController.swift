//
//  ARViewController.swift
//  Project_19
//
//  Created by Daniel Ingo on 10/5/22.
//

import UIKit
import RealityKit

class ARViewController: UIViewController {
    @IBOutlet var arView: ARView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let anchor = AnchorEntity()
        anchor.position = simd_make_float3(0, -0.5, -1)

        if let usdzModel = try? Entity.load(named: "env1") {
            anchor.addChild(usdzModel)
        }

        arView.scene.anchors.append(anchor)
        
    }
}
