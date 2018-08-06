//
//  ProfileResponseStruct.swift
//  SwiftLearnings
//
//  Created by user on 02/08/18.
//  Copyright © 2018 this. All rights reserved.
//

import Foundation
struct pro: Codable {
    var resultCode: String
    var userId: String?
    var message: String?
    private enum CodingKeys: String, CodingKey {
        case resultCode
        case userId
        case message = "Message"
    }
}
