//
//  ProfileViewController.swift
//  SwiftLearnings
//
//  Created by user on 03/08/18.
//  Copyright © 2018 this. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var profileModel: ProfileModel!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var chooseImageButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBAction func showPhotoLibraryAction(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true) {
            //After it's complete
            self.imageNameLabel.text = "Image Selected!"
            self.chooseImageButton.setTitle("Choose Other Image", for: .normal)
        }
    }
    @IBAction func saveToServerAction(_ sender: Any) {
        profileModel.saveProfileDetailsToServer(profileImage: profileImageView.image, profileName: "bharath", profileEmail: "b@g.c3")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.image = image
        } else {
            print("something went wrong while choosing image from library")
        }
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        profileImageView.layer.cornerRadius = (profileImageView.frame.width) / 10.0
        //        profileImageView.clipsToBounds = true
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        profileModel = ProfileModel()
        profileModel.profileModelDelegate = self
        //profileImageView.layer.masksToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func handleSuccessApi(message: String?) {
        //print todo!
    }
}
extension ProfileViewController: ProfileModelDelegate {
    func apiResult(message: String?, statusCode: String?) {
        guard let code = statusCode else { return }
        switch code {
        case "0":
            handleSuccessApi(message: message)
        case "2":
            print("Failure Response")
            guard let errorMessage = message else { return }
            self.showToast(message: errorMessage)
        default:
            print("default executed")
        }
    }
    func handleCustomError(error: CustomError) {
        self.showToast(message: error.description)
    }
}
