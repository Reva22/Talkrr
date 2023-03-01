//
//  Constants.swift
//  Talkrr
//
//  Created by Reva Tamaskar on 10/02/23.
//

import Foundation
import UIKit

struct Constants {
    struct MessageFields {
        static let datetime = "datetime"
        static let text = "text"
    }
}

struct MessageModel {
    let message: String
    let reciever: String?
    let sender: String?
    let isIncoming: Bool
}

struct Users {
    let email: String
    let name: String
}
