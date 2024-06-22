//
//  SceneDelegate.swift
//  Meaning Out
//
//  Created by dopamint on 6/13/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        if UserDefaultsHelper.standard.nickname.isEmpty {
            let vc = UINavigationController(rootViewController: WelcomeViewController())
            window?.rootViewController = vc
        } else {
            let vc = MeaningOutTabBarController()
            window?.rootViewController = vc
        }
        window?.makeKeyAndVisible()
    }

    func changeRootVC(_ vc: UIViewController, animated: Bool) {
        guard let window else { return }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.2, options: [.transitionCrossDissolve], animations: nil, completion: nil)
      }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

