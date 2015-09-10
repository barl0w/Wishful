//
//  AddWishViewController.swift
//  Wishful
//
//  Created by Scott Barlow on 8/24/15.
//  Copyright © 2015 Scott Barlow. All rights reserved.
//

import UIKit
import CoreData

class AddWishViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var wishImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: "imageTapped")
        
        self.wishImage.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        
        // Save Wish
        
        saveNewWish()
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        
        navigationController?.popToRootViewControllerAnimated(true)
    
    }
    
    func imageTapped() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            
            let cameraViewController = UIImagePickerController()
            cameraViewController.allowsEditing = true
            cameraViewController.sourceType = UIImagePickerControllerSourceType.Camera
            cameraViewController.delegate = self
            self.presentViewController(cameraViewController, animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.wishImage.image = image
        self.wishImage.contentMode = .ScaleAspectFit
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    func saveNewWish() {
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let wish = NSEntityDescription.insertNewObjectForEntityForName("Wish", inManagedObjectContext: context) as! Wish
        
        wish.desc = descriptionTextField.text
        wish.info = infoTextField.text
        wish.image = UIImagePNGRepresentation(self.wishImage!.image!)
        
        do {
            
            try context.save()
            
        } catch _ {
            
            // Do nothing
            
        }
        
        let request = NSFetchRequest(entityName: "Wish")
        
        var results : [AnyObject]?
        
        do {
            
            results = try context.executeFetchRequest(request)
            
        } catch _ {
            
            results = nil
            
        }
        
        if results != nil {
            
            descriptionTextField.text = ""
            infoTextField.text = ""
            wishImage.image = nil
            
        }
        
        navigationController?.popToRootViewControllerAnimated(true)
        
    }

}
