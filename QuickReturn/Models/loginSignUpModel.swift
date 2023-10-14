//
//  loginSignUpModel.swift
//  QuickReturn
//
//  Created by aryaman mittal on 13/10/23.
//

import Foundation
class Login: Codable {
    let email, password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
class RegistMail: Codable {
    let email: String

    init(email: String) {
        self.email = email
    }
}
class Registeration: Codable {
    let email, otp, firstName, lastName: String
    let password: String

    init(email: String, otp: String, firstName: String, lastName: String, password: String) {
        self.email = email
        self.otp = otp
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
    }
}
