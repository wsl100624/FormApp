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
        window.rootViewController = configRootVC()
        window.makeKeyAndVisible()
        self.window = window
    }

    func configRootVC() -> UINavigationController {
        let navVC = UINavigationController(rootViewController: ProfileCreationVC())
        navVC.setNavigationBarHidden(true, animated: false)
        return navVC
    }

}

