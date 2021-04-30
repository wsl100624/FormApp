//
//  Content.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import Foundation


enum Content {
    
    case profileCreation
    case confirmation(_ name: String? = nil)
    
    var title: String {
        switch self {
        case .profileCreation:
            return "profile creation".capitalized
        case .confirmation(let name):
            if let name = name, name != "" {
                return "Hello, \(name)!"
            } else {
                return "Hello, Friend!"
            }
        }
    }
    
    var subtitle: String {
        switch self {
        case .profileCreation:
            return "Use the form below to submit your portfolio. An email and password are required."
        case .confirmation:
            return "Your super-awesome portfolio has been successfully submitted! The details below will be public within your community!"
        }
    }
}

enum Alert {
    case email
    case password
    case url
    
    var title: String {
        switch self {
        case .email:
            return "invalid email".capitalized
        case .password:
            return "Password is too short"
        case .url:
            return "invalid web address".capitalized
        }
    }
    
    var message: String {
        switch self {
        case .email:
            return "You entered an invalid email, please try again."
        case .password:
            return "Password should be at least 8 characters, please try again."
        case .url:
            return "You entered an invalid web address, please try again or leave it blank."
        }
    }
}
