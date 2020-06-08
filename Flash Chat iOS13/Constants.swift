//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Tan Nguyen on 4/6/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

struct K {
    static let appName = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "goToChat"
    static let loginSegue = "loginToChat"


struct BrandColor{
    static let purple = "BrandPurple"
    static let  lightPurple = "BrandLightPurple"
    static let  blue = "BrandBlue"
    static let lightBlue = "BrandLightBlue"
}

struct FStore {
    static let collectionName = "messages"
    static let senderField = "sender"
    static let bodyField = "body"
    static let dateField = "date"
}

struct User {
    static let username = "tannguyen.tabby@gmail.com"
    static let password = "Tan123"
}
}
