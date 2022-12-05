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

        // let documentsURL:URL = try filemanager.url(
        //     for: .documentDirectory,
        //     in: .userDomainMask,
        //     appropriateFor: nil,
        //     create: false
        // )

        guard let documentsURL:URL = try filemanager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ), let files = try? filemanager.contentsOfDirectory(at: documentsURL) else {
                return []
            }
        print("path: ", documentsURL.path)

        // guard let path = Bundle.main.resourcePath, let
        //     files = try?
        //     filemanager.contentsOfDirectory(atPath: path) else {
        //     return []
        // }
        // print("path: ", path)
        
        var availableModels: [String] = []
        for filename in files where filename.hasSuffix("usdz") && !filename.contains("-set"){
            print("filename: ", filename)
            
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            //let model = Model(modelName: modelName)
            print("appending \(modelName)")
            availableModels.append(modelName)
        }
        return availableModels
    }()

    var setNames: [String] = {
        let filemanager = FileManager.default

        guard let path = Bundle.main.resourcePath, let
            files = try?
            filemanager.contentsOfDirectory(atPath: path) else {
            return []
        }
        var availableSetNames: [String] = []
        for filename in files where filename.hasSuffix("usdz") && filename.contains("-set") {
            let setName = filename.replacingOccurrences(of: ".usdz", with: "")
            print("appending \(setName)")
            availableSetNames.append(setName)
        }
        return availableSetNames
    }()

    
    private var modelConfirmedForPlacement: String?
    private var setConfirmedForPlacement: String?
    var scrollview = UIScrollView()
    var scrollviewContainer = UIView()
    var setScrollview = UIScrollView()
    var setScrollviewContainer = UIView()
    var imageview = UIImageView()
    var view1 = UIView()
    let buttonColor = UIColor(white: 0.5, alpha: 0.9)
    @ObservedObject var thumbnailGenerator = ThumbnailGenerator()
    var isSetPlaced = false
    var selectedAnchor: AnchorEntity?
    var anchorList = [AnchorEntity]()
    var anchorHeight = Float(0.0)
    
    @IBOutlet var switchB: UISwitch!
    var defauldBackground: ARView.Environment.Background!

    @IBAction func switchDidChange(sender: UISwitch){
        
        if sender.isOn {
            arView.environment.background = defauldBackground
        } else {
            arView.environment.background = .color(.systemGray)
        }
    }
    
   
    
    
    @IBAction func clearScreen(_ sender: UIButton) {
        for anchor in anchorList {
            arView.scene.removeAnchor(anchor)
        }
        
        
    }
    @IBAction func upHeight(_ sender: UIButton) {
        anchorHeight += 0.01
        if selectedAnchor != nil {
            selectedAnchor?.setPosition([0,anchorHeight,0], relativeTo: selectedAnchor)
        }
    }
    
    @IBAction func downHeight(_ sender: UIButton) {
        anchorHeight -= 0.01
        if selectedAnchor != nil {
            selectedAnchor?.setPosition([0,anchorHeight,0], relativeTo: selectedAnchor)
        }
    }
    
    
   // var prevValue: Float?
//    @IBAction func setHeight(_ sender: UIStepper) {
//        if selectedAnchor != nil {
//            let x = Float((selectedAnchor?.position.x)!)
//            var y = Float((selectedAnchor?.position.y)!)
//            let z = Float((selectedAnchor?.position.z)!)
//
//            sender.stepValue = -0.01
//            y = Float(sender.stepValue)
//
//            sender.
//
//            selectedAnchor?.setPosition([x,y,z], relativeTo: selectedAnchor)
//           // prevValue = y
//            //print("DEBUG: Anchor Position: \(selectedAnchor?.position)")
//        }
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defauldBackground = arView.environment.background
        //let switchB = UISwitch(frame:CGRectMake(150, 300, 0, 0))
        // this is probably an unnecessary line but I feel insecure w/out it
        let modelNames = models
        // update: I'm starting to feel insecure w/ it too now
        
        // detected that horizontal plane using beams of light
        startPlaneDetection()
        // this is what allows for tapping
        arView.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(handleTap(recognizer:))))
        
       
        
       // scroll view mumjo jumbo
        scrollview.delegate = self
        scrollviewContainer.frame = CGRect(x: 0, y: 750, width: view.frame.size.width , height: 75)
        scrollview.contentSize = CGSize(width: 1000, height:50)
        scrollviewContainer.backgroundColor = UIColor(white: 1, alpha: 0.1)
        
        
        // programmatically add button to the scroll view
        // each button has it's name set to the a model's name from the modelNames[] array
        for i in 0..<modelNames.count {
            let button = UIButton(frame: CGRect(x: 10+(90*i), y: 750 , width: 75, height: 75))
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
        
        
       ////////////// SET SCROLL VIEW STUFF /////////////////
        
        setScrollview.delegate = self
        setScrollviewContainer.frame = CGRect(x: 0, y: 650, width: view.frame.size.width , height: 75)
        setScrollview.contentSize = CGSize(width: 1000, height:50)
        setScrollviewContainer.backgroundColor = UIColor(white: 1, alpha: 0.1)
        for i in 0..<setNames.count {
            let button = UIButton(frame: CGRect(x: 10+(90*i), y: 650 , width: 75, height: 75))
            button.backgroundColor = buttonColor
            button.setTitle(setNames[i], for: .normal)
            button.setTitleColor(UIColor.clear, for: .normal)
            button.addTarget(self, action: #selector(setButtonAction), for: .touchUpInside)
            self.thumbnailGenerator.generateThumbnail(for:setNames[i], withExtension: "usdz", size: CGSize(width: 75, height: 75), button: button)
            button.layer.cornerRadius = 5
            self.setScrollview.addSubview(button)
            }
        setScrollviewContainer.addSubview(setScrollview)
        view.addSubview(setScrollviewContainer)
        
        setScrollview.translatesAutoresizingMaskIntoConstraints = false
        setScrollview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setScrollview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        setScrollview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        setScrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
    
    
    func startPlaneDetection() {
        // this line works if run on real iPhone not simulator
        arView.automaticallyConfigureSession = true
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        arView.session.run(configuration)
        
    }
    
    // guess what this func handles...
    // handles the tap to place the prop
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
                placeObject(modelName: modelName, at: worldPos, isProp: true)
            } else {
                print("DEBUG: Tap handled.. modelConfirmedForPlacement NULL ")
            }
            if let setName = setConfirmedForPlacement {
                
                // THIS ENSURES ONLY 1 SET CAN BE PLACED AT A TIME
                if !isSetPlaced {
                    placeObject(modelName: setName, at: worldPos, isProp: false)
                    isSetPlaced = true
                } else {
                    print("DEBUG: A Set has already been placed")
                }
                
            } else {
                print("DEBUG: Tap handled.. setConfirmedForPlacement NULL ")
            }
           // print("DEBUG: Tap handled.. no function yet")
        }
    }
    
    func placeObject(modelName: String, at location:SIMD3<Float>, isProp: Bool) {
        selectedAnchor = AnchorEntity(world: location)
        selectedAnchor?.name = modelName + "Anchor"
        let model = try! Entity.loadModel(named: modelName, in: nil)
        
        //selectedEntity = model
        
        selectedAnchor?.addChild(model)
        
        arView.scene.addAnchor(selectedAnchor!)

        //selectedAnchor = objectAnchor
        anchorList.append(selectedAnchor!)
        if isProp {
            arView.installGestures(/*[.translation, .rotation,.scale]*/.all, for: model)
            model.generateCollisionShapes(recursive: true)
        }
        arView.enableObjectRemoval(modelName: modelName)
        
    }
    
    
    
    
    
    //// BUTTON LOGIC ////
    
    var prevButton: UIButton!
    @objc func buttonAction(sender: UIButton!) {
        // double click same button
        if prevButton == sender {
            resetButton()
            prevButton = nil
            return
        } else {
            if prevButton != nil {
                resetButton()
            }
        }
        prevButton = sender
        sender.backgroundColor = UIColor(white: 1, alpha: 0.25)
        sender.layer.opacity = 0.5
        modelConfirmedForPlacement = sender.currentTitle!
       
        print("\(sender.currentTitle!) tapped")
    }
    
    @objc func resetButton() {
        if prevButton != nil {
            prevButton.backgroundColor = buttonColor
            prevButton.layer.opacity = 1
            modelConfirmedForPlacement = nil
            setConfirmedForPlacement = nil
            
            print("resetting: \(prevButton.currentTitle)")
        }
    }
    
    
    @objc func setButtonAction(sender: UIButton!) {
        // double click same button
        if prevButton == sender {
            resetButton()
            prevButton = nil
            return
        } else {
            if prevButton != nil {
                resetButton()
            }
        }
        prevButton = sender
        sender.backgroundColor = UIColor(white: 1, alpha: 0.25)
        sender.layer.opacity = 0.5
        setConfirmedForPlacement = sender.currentTitle!
        print("\(sender.currentTitle!) tapped")
    }
    
    

}

//extension ARViewController {
//    @IBAction func returnToParent(_ sender: Any) {
//        print("KKKKKKKKKKK")
//        performSegue(withIdentifier: "returntoSetList", sender: nil)
//    }
//}


private var model_name: String?
extension ARView {
  func enableObjectRemoval(modelName: String) {
      let longPressGuestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
      self.addGestureRecognizer(longPressGuestureRecognizer)
      model_name = modelName
  }
  
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
      let location = recognizer.location(in: self)
      
      if let entity = self.entity(at: location) {
          if let anchorEntity = entity.anchor
                
          {
              anchorEntity.removeFromParent()
              print("DEBUG: Removed model: \(model_name) at anchor: \(anchorEntity.name)")
          }
      }
  }
}

