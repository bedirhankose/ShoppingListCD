//
//  DetailsViewController.swift
//  ShoppingListCD
//
//  Created by Bedirhan Köse on 26.12.22.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameProduct: UITextField!
    @IBOutlet weak var priceProduct: UITextField!
    @IBOutlet weak var sizeProduct: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeTheKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func closeTheKeyboard() {
        view.endEditing(true)
        
    }
    
    @IBAction func SaveButton(_ sender: Any) {
    }
    
   

}
