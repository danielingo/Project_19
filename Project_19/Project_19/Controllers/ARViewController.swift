//
//  ARViewController.swift
//  Project_19
//
//  Created by Daniel Ingo on 10/5/22.
//

import UIKit
import ARKit
import RealityKit

class ARViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var arView: ARView!

    // this guy automatically adds the filename of usdz models to the "models" array
    // this is just an array of model names not the actual model entities
    private var models: [String] =  {
        let filemanager = FileManager.default

        guard let path = Bundle.main.resourcePath, let
            files = try?
            filemanager.contentsOfDirectory(atPath: path) else {
            return []
        }
        var availableModels: [String] = []
        for filename in files where filename.hasSuffix("usdz") {
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            //let model = Model(modelName: modelName)
            print("appending \(modelName)")
            availableModels.append(modelName)
        }
        return availableModels
    }()

    
    private var modelConfirmedForPlacement: String?
    private var prevSender: UIButton!
    var scrollview = UIScrollView()
    var scrollviewContainer = UIView()
    var imageview = UIImageView()
    var view1 = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // this is probably an unnecessary line but I feel insecure w/out it
        let modelNames = models

        startPlaneDetection()
        // this is what allows for tapping
        arView.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(handleTap(recognizer:))))
        
        
        
        
       // scroll view mumjo jumbo
        scrollview.delegate = self
        scrollviewContainer.frame = CGRect(x: 0, y: 720, width: view.frame.size.width , height: 50)
        scrollview.contentSize = CGSize(width: 1000, height:50)
        scrollviewContainer.backgroundColor = UIColor(white: 1, alpha: 0.1)
        
        
        // programmatically add button to the scroll view
        // each button has it's name set to the a model's name from the modelNames[] array
        for i in 0..<modelNames.count {
            let button = UIButton(frame: CGRect(x: 10+(70*i), y: 720 , width: 50, height: 50))
            button.backgroundColor = .gray
            button.setTitle(modelNames[i], for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.scrollview.addSubview(button)
            }
        scrollviewContainer.addSubview(scrollview)
        view.addSubview(scrollviewContainer)
        
        // do I know what any of this does?? lmao
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        


    }
    
    
    func startPlaneDetection() {
        // this line works if run on real iPhone not simulator
        arView.automaticallyConfigureSession = true
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        arView.session.run(configuration)
        
    }
    
    // guess what this func handles...
    @objc
    func handleTap(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: arView)
        
        // \(^>^)/ raaaaaays
        let results = arView.raycast(
            from: tapLocation, allowing: .estimatedPlane,
            alignment: .horizontal)
        
        if let firstResult = results.first {
            let worldPos = simd_make_float3(
                firstResult.worldTransform.columns.3)
                    
            // unwrapping so doesn't place NULL if button not selected
            if let modelName = modelConfirmedForPlacement {
                placeObject(modelName: modelName, at: worldPos)
            } else {
                print("DEBUG: Tap handled.. modelConfirmedForPlacement NULL ")
            }
           // print("DEBUG: Tap handled.. no function yet")
        }
    }
    
    func placeObject(modelName: String, at location:SIMD3<Float>) {
        let objectAnchor = AnchorEntity(world: location)
        
        let model = try! Entity.loadModel(named: modelName, in: nil)
        
        objectAnchor.addChild(model)
        
        arView.scene.addAnchor(objectAnchor)
    }
    
    func createModel() -> ModelEntity {
        let sphere = MeshResource.generateSphere(radius: 0.1)
        let sphereMaterial = SimpleMaterial(color: .red, roughness: 0, isMetallic: true)
        let sphereEntity = ModelEntity(mesh: sphere, materials: [sphereMaterial])
        return sphereEntity
    }
    
    var beenPressed = false
    @objc func buttonAction(sender: UIButton!) {
        //let anchor = AnchorEntity()
        //anchor.position = simd_make_float3(0, -0.5, -1)
        if prevSender == sender {
            beenPressed = true
        } else {
            prevSender = sender
            beenPressed = false
        }
        
        if beenPressed {
            sender.backgroundColor = .gray
            modelConfirmedForPlacement = nil
            beenPressed = false
        } else {
            let modelName = sender.currentTitle!
            modelConfirmedForPlacement = modelName

            sender.backgroundColor = UIColor(white: 1, alpha: 0.3)
            
        }


        print("\(String(describing: sender.currentTitle)) tapped")
    }
    
}
