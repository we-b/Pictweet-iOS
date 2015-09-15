//
//  EditProfileViewController.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/09/10.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UserDelegate {
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!

    var currentUser: User!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = User(attribute: PFUser.currentUser()!)
        currentUser.delegate = self
        nameTextField.text = currentUser.name
        editButton.roundCorner()
        profileImageView.makeCircle()
        configureSelectImageButton()
        imagePicker.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "BACK", style: UIBarButtonItemStyle.Plain, target: self, action: "backToMyPageViewController")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - configure views
    
    func configureSelectImageButton() {
        selectImageButton.roundCorner()
        selectImageButton.drawBorderByMainColor()
    }
    
    //MARK - delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        profileImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didFinishUpdateUser() {
        profileImageView.image = currentUser.image
    }
    
    //MARK - action
    
    func backToMyPageViewController() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func tapSelectImageButton(sender: UIButton) {
        self.imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func tapEditButton(sender: UIButton) {
        let name = nameTextField.text
        let image = profileImageView.image
        if name.isEmpty || image == nil { return }
        let user = User(name: name, image: image!)
        let callback = { () in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        user.update(callback)
    }

}
