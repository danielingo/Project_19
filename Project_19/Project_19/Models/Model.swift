//
//  Model.swift
//  Project_19
//
//  Created by Daniel Ingo on 10/12/22.
//
import RealityKit
import Combine

class Model {
    var modelName: String
    //var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        //self.image = UIImage(named: modelName)!
        let filename = modelName + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename).sink(receiveCompletion: {loadCompletion in
            
            if case let .failure(error) = loadCompletion {
                print("DEBUG: Unable to load modelEntity \(modelName)")
            }
            self.cancellable?.cancel()
                
            
            
            
        }, receiveValue: { modelEntity in
            //if let modelEntity = modelEntity as? ModelEntity {
                self.modelEntity = modelEntity
                self.cancellable?.cancel()
                print("DEBUG: Succussfully loaded modelEntity \(modelName)")
                
                
           // }
        })
        
    }
    
}
