//
//  DetailsViewController.swift
//  ShoppingListCD
//
//  Created by Bedirhan Köse on 26.12.22.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameProduct: UITextField!
    @IBOutlet weak var priceProduct: UITextField!
    @IBOutlet weak var sizeProduct: UITextField!
    
    var ChosenProductName = ""
    var ChosenProductID : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ChosenProductName != "" {
            //It shows CoreData chosen product information.
            if let uuidString = ChosenProductID?.uuidString {
                print(uuidString)
            }
            
        } else{
            nameProduct.text = ""
            priceProduct.text = ""
            sizeProduct.text = ""
        }

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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let shopping = NSEntityDescription.insertNewObject(forEntityName: "ShoppingDatabase", into: context)
        shopping.setValue(nameProduct.text!, forKey: "name")
        shopping.setValue(sizeProduct.text!, forKey: "size")
        
        if let price = Int(priceProduct.text!) {
            shopping.setValue(price, forKey: "price")
        }
        
        //Universal unique id
        
        shopping.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        
        shopping.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("it has been saved..")
        }catch {
            print("Error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("Data has been entered."), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
   

}
