//
//  ThumbnailGenerator.swift
//  Project_19
//
//  Created by Daniel Ingo on 12/1/22.
//

import QuickLookThumbnailing
import SwiftUI
import Combine
import UIKit

class ThumbnailGenerator: ObservableObject {
    @Published var thumbnailImage: UIImage?
    
    func generateThumbnail(for resource: String, withExtension: String = "usdz", size: CGSize, button: UIButton, isProp: Bool) {
        
        do {
            let documentsURL:URL = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            if !isProp {
                let directoryURL = documentsURL.appendingPathComponent("Sets")
                
                let fname = resource + ".usdz"
                let url = directoryURL.appendingPathComponent(fname)
                
                let scale = UIScreen.main.scale
                let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: scale, representationTypes: .all)
                let generator = QLThumbnailGenerator.shared
                
                generator.generateRepresentations(for: request) {(thumbnail, type, error) in
                    DispatchQueue.main.async {
                        if thumbnail == nil || error != nil {
                            print("Error generating thumbnail: \(error?.localizedDescription)")
                            return
                        } else {
                            print("DEBUG: Generating thumbnail")
                            self.thumbnailImage = thumbnail!.uiImage
                            button.setBackgroundImage(self.thumbnailImage, for: .normal)

                        }
                    }

                }
            } else {
                let directoryURL = documentsURL.appendingPathComponent("Props")
                
                let fname = resource + ".usdz"
                let url = directoryURL.appendingPathComponent(fname)
                
                let scale = UIScreen.main.scale
                let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: scale, representationTypes: .all)
                let generator = QLThumbnailGenerator.shared
                
                generator.generateRepresentations(for: request) {(thumbnail, type, error) in
                    DispatchQueue.main.async {
                        if thumbnail == nil || error != nil {
                            print("Error generating thumbnail: \(error?.localizedDescription)")
                            return
                        } else {
                            print("DEBUG: Generating thumbnail")
                            self.thumbnailImage = thumbnail!.uiImage
                            button.setBackgroundImage(self.thumbnailImage, for: .normal)

                        }
                    }

                }
            }
        } catch {
            print("Unable to load thumbnail: ", error)
        }
        
//        guard let url = Bundle.main.url(forResource: resource, withExtension: withExtension) else {
//
//            print("resource: ", resource)
//
//            print("Unable to load thumbnail")
//            return
//        }
//        let scale = UIScreen.main.scale
//        let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: scale, representationTypes: .all)
//        let generator = QLThumbnailGenerator.shared
//
//        generator.generateRepresentations(for: request) {(thumbnail, type, error) in
//            DispatchQueue.main.async {
//                if thumbnail == nil || error != nil {
//                    print("Error generating thumbnail: \(error?.localizedDescription)")
//                    return
//                } else {
//                    print("DEBUG: Generating thumbnail")
//                    self.thumbnailImage = thumbnail!.uiImage
//                    button.setBackgroundImage(self.thumbnailImage, for: .normal)
//
//                }
//            }
//
//        }
    }
    
}
