//
//  DetailsViewController.swift
//  ShoppingListCD
//
//  Created by Bedirhan Köse on 26.12.22.
//

import UIKit

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameProduct: UITextField!
    @IBOutlet weak var priceProduct: UITextField!
    @IBOutlet weak var sizeProduct: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeTheKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @objc func closeTheKeyboard() {
        view.endEditing(true)
        
    }
    
    @IBAction func SaveButton(_ sender: Any) {
    }
    
   

}
