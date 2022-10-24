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

    //update to model obj
    private var modelConfirmedForPlacement: Model?

    private var models: [Model] =  {
        /*
        let filemanager = FileManager.default

        guard let path = Bundle.main.resourcePath, let
            files = try?
            filemanager.contentsOfDirectory(atPath: path) else {
            return []
        }
        var availableModels: [Model] = []
        for filename in files where filename.hasSuffix("usdz") {
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            let model = Model(modelName: modelName)
            print("appending \(modelName)")
            availableModels.append(model)
        }
        return availableModels
         */
        var availableModels: [Model] = []
        
        let model = Model(modelName: "env1")
        model.modelEntity = file
        availableModels.append(model)
        
        return availableModels

    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let scrollView = UIScrollView(frame: CGRect(x: 100, y: 100, width: 100, height: 500))
        //self.view.addSubview(scrollView)

        for i in 0..<3 {
            let button = UIButton(frame: CGRect(x: 100, y: 100+(100*i), width: 100, height: 50))
              button.backgroundColor = .green
              button.setTitle("Button\(i)", for: .normal)
              button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
              self.view.addSubview(button)
        }
        
       
        

        
        let anchor = AnchorEntity()
        anchor.position = simd_make_float3(0, -0.5, -1)
        
        if models[0].modelEntity != nil {
            print(models[0].modelEntity!)

        } else {
            print("model size: \(models.count)")
        }
        //anchor.addChild(models[0].modelEntity!)

        /*
        if let env1 = try? Entity.load(named: "env1") {
            anchor.addChild(env1)
        }
         */
        
        /*
        modelConfirmedForPlacement = models[0]
        
        if let model = self.modelConfirmedForPlacement {
            if let modelEntity = model.modelEntity {
                //anchor.addChild(modelEntity)
                print("DEBUD: Adding model to scene -> \(model.modelName)")
                let anchorEntity = AnchorEntity()
                anchorEntity.position = simd_make_float3(0, -0.5, -1)

                anchorEntity.addChild(modelEntity)
                arView.scene.addAnchor(anchorEntity)

            } else {
                print("Model no load")
            }
        }
         */
    
        
        
       
        //arView.scene.anchors.append(anchor)
        
    }
    @objc func buttonAction(sender: UIButton!) {
        print("\(sender.titleLabel!) tapped")
    }
    
}
