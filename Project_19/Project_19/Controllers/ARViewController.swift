//
//  ARViewController.swift
//  Project_19
//
//  Created by Daniel Ingo on 10/5/22.
//

import UIKit
import RealityKit

class ARViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var arView: ARView!

    //update to model obj
    private var modelConfirmedForPlacement: Model?

    private var models: [Model] =  {
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
    }()

    var scrollview = UIScrollView()
    var imageview = UIImageView()
    var view1 = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //let scrollView = UIScrollView(frame: CGRect(x: 100, y: 100, width: 100, height: 500))
        //self.view.addSubview(scrollView)
        let modelNames = ["env1", "pokemart"]

       
//        for i in 0..<modelNames.count {
//            let button = UIButton(frame: CGRect(x: 100, y: 100+(100*i), width: 100, height: 50))
//              button.backgroundColor = .green
//              button.setTitle(modelNames[i], for: .normal)
//              button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//              scrollview.addSubview(button)
//        }
//        self.view.addSubview(scrollview)
//

        imageview.frame = CGRect(x: 0, y: 0, width: view.frame.size.width , height: 1000)
        imageview.image = UIImage(named: "image")
        scrollview.delegate = self
        scrollview.contentSize = CGSize(width: imageview.frame.width, height: imageview.frame.height)

        //scrollview.backgroundColor = UIColor.red
        imageview.backgroundColor =  UIColor.green

        for i in 0..<modelNames.count {
            let button = UIButton(frame: CGRect(x: 10, y: 50+(50*i), width: 50, height: 30))
            button.backgroundColor = .green
            button.setTitle(modelNames[i], for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.scrollview.addSubview(button)
            }
        //self.scrollview.addSubview(imageview)
        
        view.addSubview(scrollview)
        scrollview.translatesAutoresizingMaskIntoConstraints = false



        scrollview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        

        /*
        if let env1 = try? Entity.load(named: "env1") {
            anchor.addChild(env1)
        }
         */
        

        
    }
    @objc func buttonAction(sender: UIButton!) {
        let anchor = AnchorEntity()
        anchor.position = simd_make_float3(0, -0.5, -1)
        
        let modelName = sender.currentTitle!
        
        if let model = try? Entity.load(named: modelName) {
            anchor.addChild(model)
        }
        
        
        arView.scene.anchors.append(anchor)
        print("\(String(describing: sender.currentTitle)) tapped")
    }
    
}
