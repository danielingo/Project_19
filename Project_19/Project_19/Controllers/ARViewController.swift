//
//  ARViewController.swift
//  Project_19
//
//  Created by Daniel Ingo on 10/5/22.
//

import UIKit
import ARKit
import RealityKit
import SwiftUI

class ARViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var arView: ARView!

    // this guy automatically adds the filename of usdz models to the "models" array
    // this is just an array of model names not the actual model entities
    // Yo Linsey this be where firebase search might want to live
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
    var scrollview = UIScrollView()
    var scrollviewContainer = UIView()
    var imageview = UIImageView()
    var view1 = UIView()
    let buttonColor = UIColor(white: 0.5, alpha: 0.9)
    @ObservedObject var thumbnailGenerator = ThumbnailGenerator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // this is probably an unnecessary line but I feel insecure w/out it
        let modelNames = models

        startPlaneDetection()
        // this is what allows for tapping
        arView.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(handleTap(recognizer:))))
        
        // change background
        //arView.environment.background = .color(.systemGray)
        
       // scroll view mumjo jumbo
        scrollview.delegate = self
        scrollviewContainer.frame = CGRect(x: 0, y: 720, width: view.frame.size.width , height: 50)
        scrollview.contentSize = CGSize(width: 1000, height:50)
        scrollviewContainer.backgroundColor = UIColor(white: 1, alpha: 0.1)
        
        
        // programmatically add button to the scroll view
        // each button has it's name set to the a model's name from the modelNames[] array
        for i in 0..<modelNames.count {
            let button = UIButton(frame: CGRect(x: 10+(90*i), y: 720 , width: 75, height: 75))
            button.backgroundColor = buttonColor
            button.setTitle(modelNames[i], for: .normal)
            button.setTitleColor(UIColor.clear, for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
            self.thumbnailGenerator.generateThumbnail(for:modelNames[i], withExtension: "usdz", size: CGSize(width: 75, height: 75), button: button)
            
            button.layer.cornerRadius = 5
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
        
        model.generateCollisionShapes(recursive: true)
        arView.installGestures([.translation, .rotation,.scale], for: model)
        
    }
    
//    extension ARView {
//        func enableObjectRemoval() {
//            let longPressGuestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recon))
//        }
//    }
    
    
//    func createModel() -> ModelEntity {
//        let sphere = MeshResource.generateSphere(radius: 0.1)
//        let sphereMaterial = SimpleMaterial(color: .red, roughness: 0, isMetallic: true)
//        let sphereEntity = ModelEntity(mesh: sphere, materials: [sphereMaterial])
//        return sphereEntity
//    }
    
    private var prevSender: UIButton!
    var selectedButton: UIButton!
    @objc func buttonAction(sender: UIButton!) {
        
        // button selection logic
        if selectedButton != sender {
            if selectedButton != nil {
                resetButton(button: selectedButton)
            }
            selectedButton = sender
            selectedButton.backgroundColor = UIColor(white: 1, alpha: 0.25)
            selectedButton.layer.opacity = 0.5
            modelConfirmedForPlacement = selectedButton.currentTitle!
            //placeObject(modelName: selectedButton.currentTitle!, at: [0,0,0])
            
        } else {
            resetButton(button: sender)
        }
        

        print("\(String(describing: sender.currentTitle)) tapped")
    }
    
    @objc func resetButton(button: UIButton!) {
        button.backgroundColor = buttonColor
        button.layer.opacity = 1
        modelConfirmedForPlacement = nil
    }
    
//    @objc func handleLongPress(recongizer: UILongPressGestureRecognizer) {
//        if let
//    }
//
}
