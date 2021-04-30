//
//  Profile.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import Foundation

// Decision: - stuct model
// Benefit: - it come with a free init. And it's looks clean in code when creating profile and submit it to network request later.

struct Profile {
    var email, password: String
    var firstName, website: String?
}
