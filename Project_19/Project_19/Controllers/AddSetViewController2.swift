//
//  AddSetViewController.swift
//  Project_19
//
//  Created by Natasha Bohra on 11/8/22.
//

import Foundation
import UIKit
import FirebaseFirestore
import RealityKit

class AddSetViewController: UITableViewController {
    
    var tag = "" {
        didSet {
            tagLabel.text = tag
        }
    }
    var newTitle = "" {
        didSet {
            nameTextField.text = newTitle
        }
    }
    var importedSetURL = ""
    var modelURL: URL?
    
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var tagLabel: UILabel!
    
    override func viewDidLoad() {
        tag = "Bubblegum"
        newTitle = "set name here"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("DDDDDDD")
        if segue.identifier == "PickTag",
           let tagPickerViewController = segue.destination as? TagPickerViewController {
            print("EEEEEEEE")
            tagPickerViewController.tagDataSource.selectedTag = tag
            print("FFFFFFF")
        } else if segue.identifier == "showNewARView",
           let ARViewVC = segue.destination as? ARViewController {
            print("GGGGGGG")
            if let name = nameTextField.text, !name.isEmpty {
                print("HHHHHHHH")
                newTitle = name
                print("Title: ", newTitle)
                ARViewVC.title = newTitle
                print("IIIIIIIII")
            }
        }
        print("JJJJJJJJJ")
    }
    
    func downloadUSDZ(url: URL) {
        
        // url.startAccessingSecurityScopedResource()
        
        // let documentsURL:URL = Bundle.main.resourceURL!
        do {
            let documentsURL:URL = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            // documentsURL.startAccessingSecurityScopedResource()
            let directoryURL = documentsURL.appendingPathComponent("Sets")
            if !FileManager.fileExists(atPath: directoryURL.path) {
                do {
                    try FileManager.default.createDirectory(atPath: directoryURL.path, 
                                                            withIntermediateDirectories: true, 
                                                            attributes: nil)
                } catch {
                    print("Unable to create directory: \(error.debugDescription)")
                }
            }
            let saveURL = directoryURL.appendingPathComponent(url.lastPathComponent)
            // saveURL.startAccessingSecurityScopedResource()
            do {
                
                try FileManager.default.copyItem(at: url, to: saveURL)
                
                print("saveURL: ", saveURL)
            } catch (let writeError) {
                print("Error creating a file \(saveURL) : \(writeError)")
            }
            
            // saveURL.stopAccessingSecurityScopedResource()
            // documentsURL.stopAccessingSecurityScopedResource()
            
            // url.stopAccessingSecurityScopedResource()
        } catch {
            print(error)
        }
        
    }
    
}

extension AddSetViewController {
    
//    @IBAction func importFromUserFiles(_ sender: Any) {
//        let controller = UIDocumentPickerViewController(
//            documentTypes: ["public.3d-content"], // only want user to select 3D models
//            in: .import // mode is import file
//        )
//        controller.delegate = self
//        if #available(iOS 11.0, *) {
//            controller.allowsMultipleSelection = false
//        }
//    }
    
    @IBAction func importButtonTapped() {
        let docPicker = UIDocumentPickerViewController(
            documentTypes: ["public.3d-content"],
            in: .import
        )
        docPicker.delegate = self
        if #available(iOS 11.0, *) {
            docPicker.allowsMultipleSelection = false
            docPicker.modalPresentationStyle = .fullScreen
        }
        present(
            docPicker,
            animated: true,
            completion: nil
        )
    }
    
    @IBAction func unwindFromARView(segue: UIStoryboardSegue) {
        if let ARViewVC = segue.source as? ARViewController {
            print(ARViewVC.title!)
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func unwindWithSelectedTag(segue: UIStoryboardSegue) {
        if let tagPickerViewController = segue.source as? TagPickerViewController,
           let selectedTag = tagPickerViewController.tagDataSource.selectedTag {
            tag = selectedTag
        }
    }
    
}

extension AddSetViewController: UIDocumentPickerDelegate {
    @available(iOS 11.0, *)
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("YEEEET1")
        guard controller.documentPickerMode == .import, let url = urls.first else {
            print("YEEEEET3")
            
            return
        }
        print("YEEEET4")
        importedSetURL = url.path
        print("importedSetURL", importedSetURL)
        
//        let importedSet = try? Entity.load(contentsOf: url)
        downloadUSDZ(url: url)
        print("YEEEET5")
        
        controller.dismiss(animated: true)
    }
    
//    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
//
//
//
//        controller.dismiss(animated: true)
//    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
}
