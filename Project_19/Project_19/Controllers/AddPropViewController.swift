//
//  AddPropViewController.swift
//  Project_19
//
//  Created by Linsey Chen on 12/4/22.
//

import Foundation
import UIKit
import FirebaseFirestore
import RealityKit

class AddPropViewController: UITableViewController {

    var newTitle = "" {
        didSet {
            nameTextField.text = newTitle
        }
    }
    var importedPropURL = ""
    var propURL: URL

    @IBOutlet weak var nameTextField : UITextField!

    override func viewDidLoad() {
        newTitle = "prop name here"
    }

    // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //     print("LLLLL")
    //     if segue.identifier == "returntoPropList",
    //        let PListVC = segue.destination as? PropListViewController {
    //         print("MMMMM")
    //         if let name = nameTextField.text, !name.isEmpty {
    //             print("NNNNNNNN")
    //             newTitle = name
    //             print("Title: ", newTitle)
    //             downloadUSDZ(url: propURL, propName: newTitle)
    //             // ARViewVC.title = newTitle
    //             print("OOOOOOO")
    //         }
    //     }
    //     print("PPPPPPPP")
    // }

    func downloadUSDZ(url: URL, propName: String) {
        
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
            let directoryURL = documentsURL.appendingPathComponent("Props")
            if !FileManager.default.fileExists(atPath: directoryURL.path) {
                do {
                    try FileManager.default.createDirectory(atPath: directoryURL.path, 
                                                            withIntermediateDirectories: true, 
                                                            attributes: nil)
                } catch {
                    print("Unable to create directory: ", error)
                }
            }
            let fullPropName = propName + ".usdz"
            let saveURL = directoryURL.appendingPathComponent(fullPropName)
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

extension AddPropViewController {
        
    @IBAction func importButtonTapped() {
        let docPicker = UIDocumentPickerViewController(
            documentTypes: ["public.3d-content"],
            in: .import
        )
        docPicker.delegate = self
        if #available(iOS 11.0, *) {
            docPicker.allowsMultipleSelection = true
            docPicker.modalPresentationStyle = .fullScreen
        }
        present(
            docPicker,
            animated: true,
            completion: nil
        )
    }

    @IBAction func doneButtonTapped() {
        print("MMMMM")
        if let name = nameTextField.text, !name.isEmpty {
            print("NNNNNNNN")
            newTitle = name
            print("Title: ", newTitle)
            downloadUSDZ(url: propURL, propName: newTitle)
            // ARViewVC.title = newTitle
            print("OOOOOOO")
        }        
        print("PPPPPPP")

        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddPropViewController: UIDocumentPickerDelegate {
    @available(iOS 11.0, *)
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("YEEEET1")
        guard controller.documentPickerMode == .import, let url = urls.first else {
            print("YEEEEET3")
            
            return
        }

        // if controller.documentPickerMode == .import {
        //     for url in urls {
        //         importedPropURL = url.path
        //         print("importedPropURL", importedPropURL)

        //         downloadUSDZ(url: url)
        //     }
        // }

        print("YEEEET4")
        importedPropURL = url.path
        print("importedPropURL", importedPropURL)

        propURL = url
        
//        let importedProp = try? Entity.load(contentsOf: url)
        
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