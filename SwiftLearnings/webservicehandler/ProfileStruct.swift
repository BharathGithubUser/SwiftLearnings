//
//  ProfileStruct.swift
//  SwiftLearnings
//
//  Created by user on 02/08/18.
//  Copyright © 2018 this. All rights reserved.
//

import Foundation
//struct ProfileResponse: Codable {
//    var resultCode: String
//    var userId: String?
//    var message: String?
//    private enum CodingKeys: String, CodingKey {
//        case resultCode
//        case userId
//        case message = "Message"
//    }
//}
struct ProfileResponse: Codable {
    let resultCode, message: String
}
