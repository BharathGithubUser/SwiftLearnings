//
//  ProfileModel.swift
//  SwiftLearnings
//
//  Created by user on 02/08/18.
//  Copyright © 2018 this. All rights reserved.
//

import Foundation
import UIKit

/// This protocol is to implement the api response action
protocol ProfileModelDelegate: class {
    func apiResult(message: String?, statusCode: String?)
    func handleCustomError(error: CustomError)
}
class ProfileModel {
    // MARK: - Properties
    weak var profileModelDelegate: ProfileModelDelegate?
    var userId: String?
    // MARK: - Methods
    /// It creates or update the user profile
    /// - Parameters:
    ///   - request: request object with necessary parameter
    ///   - Handler: It contains either the data or the error
    func saveProfileDetailsToServer(profileImage: UIImage?, profileName: String, profileEmail: String) {
        let reqUrlString = Url.baseURL + Url.imageUpload
        let profileParams = ["email": profileEmail, "name": profileName]
        let imageFile = UIImagePNGRepresentation(profileImage!) ?? UIImagePNGRepresentation(UIImage(named: "splash")!)
        ApiCallHandler().uploadImageAndData(image: imageFile!, requestParams: profileParams, routeUrl: reqUrlString ) { (data, apiError) in
            guard let dataValue = data else {
                guard let customError = apiError else { return }
                self.profileModelDelegate?.handleCustomError(error: customError)
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ProfileResponse.self, from: dataValue)
                self.profileModelDelegate?.apiResult(message: result.message, statusCode: result.resultCode)
            } catch let decodeError {
                print(decodeError)
            }
        }
    }
    
}
