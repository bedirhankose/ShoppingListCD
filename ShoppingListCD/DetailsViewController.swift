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
    @IBOutlet weak var saveButton: UIButton!
    
    
    var ChosenProductName = ""
    var ChosenProductID : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ChosenProductName != "" {
            
            saveButton.isHidden = true
            
            //It shows CoreData chosen product information.
            if let uuidString = ChosenProductID?.uuidString {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingDatabase")
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
                fetchRequest.returnsObjectsAsFaults = false
                
                do {
                    let results = try context.fetch(fetchRequest)
                    
                    if results.count > 0 {
                        for result in results as! [NSManagedObject] {
                            if let name = result.value(forKey: "name") as? String {
                                nameProduct.text = name
                            }
                            
                            if let price = result.value(forKey: "price") as? Int {
                                priceProduct.text = String(price)
                            }
                            
                            if let size = result.value(forKey: "size") as? String {
                                sizeProduct.text = size
                            }
                            
                            if let imageData = result.value(forKey: "image") as? Data {
                                let image = UIImage(data: imageData)
                                imageView.image = image
                            }
                        }
                    }
                
                }catch {
                    print("error")
                }
                
                
            }
            
        } else{
            saveButton.isHidden = false
            saveButton.isEnabled = false
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
        saveButton.isEnabled = true
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
