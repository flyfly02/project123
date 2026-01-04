//
//  SceneDelegate.swift
//  project123
//
//  Created by Илья Богуш on 3.01.26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let startVC = StartViewController()
        let navController = UINavigationController(rootViewController:startVC )
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        
    }
}

