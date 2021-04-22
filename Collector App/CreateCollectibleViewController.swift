//
//  CreateCollectibleViewController.swift
//  Collector App
//
//  Created by ESHITA on 07/10/19.
//  Copyright © 2019 ESHITA. All rights reserved.
//

import UIKit

class CreateCollectibleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    var pickerController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerController.delegate = self
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage{
            imageView.image = image
        }
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mediaFolderTapped(_ sender: Any) {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: Any) {
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func addTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let collectible = CollectibleData(context: context)
            collectible.title = titleTextField.text
            collectible.image = imageView.image?.jpegData(compressionQuality: 1.0)
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
        }
        
        
        
        navigationController?.popViewController(animated: true)
        
    }
    
    

}
