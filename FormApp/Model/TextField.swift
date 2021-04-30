//
//  TextField.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import Foundation

// Decision: - Make an enum for all text fields.
// Benefit: - it helps other dev to understand the structure of the Profile Creation screen. Usually it's also a way to setup tableView or collectionView's sections.

enum TextField: String {
    case firstname = "first name"
    case email = "email address"
    case password
    case website = "personal website"
}
