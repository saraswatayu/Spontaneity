//
//  ProfileViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/8/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imageView: UIImageView?
    @IBOutlet var name: UILabel?
    @IBOutlet var email: UILabel?
    
    @IBOutlet var signout: UIButton?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView?.image = UIImage(named: "769-male.png")
        
        var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("showImagePicker"))
        self.imageView?.addGestureRecognizer(tapGesture)
        signout?.layer.cornerRadius = 4.0
        imageView?.layer.cornerRadius = 60.0
        imageView?.clipsToBounds = true
    }
    
    func showImagePicker() {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        

        let photo = info[UIImagePickerControllerOriginalImage] as UIImage
        imageView?.image = photo
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        

    }
    
    @IBAction func logout() {
        PFUser.logOut()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
