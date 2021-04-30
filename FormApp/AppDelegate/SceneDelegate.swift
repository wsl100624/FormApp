//
//  SceneDelegate.swift
//  FormApp
//
//  Created by Will Wang on 4/29/21.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        
        // Decision: - I prefer using pure code to write application, so I configure root view controller from here
        // Benefit: - It'll eventually cut off a lot of debugging time, compared with swithing between storyboard and code back and forth
        
        window.rootViewController = configRootVC()
        window.makeKeyAndVisible()
        self.window = window
    }

    func configRootVC() -> UINavigationController {
        
        // Decision: - I used navigation controller here
        // Benefit: - Comparing with model presentation style, I think navigation controller come with a smoother UX when we bringing user to each step, especially for the onboarding process like this app.
        
        let navVC = UINavigationController(rootViewController: ProfileCreationVC())
        navVC.setNavigationBarHidden(true, animated: false)
        return navVC
    }

}

