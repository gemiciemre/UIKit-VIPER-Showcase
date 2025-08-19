//
//  AppDelegate.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 16.08.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let dependencyContainer = DependencyContainer.shared
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let productListViewController = ProductListRouter.createProductListModule()
        window?.rootViewController = productListViewController
        window?.makeKeyAndVisible()
        
        // Configure navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        // Extend background to the edges
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.standardAppearance = appearance
        navigationBarAppearance.scrollEdgeAppearance = appearance
        navigationBarAppearance.compactAppearance = appearance
        navigationBarAppearance.compactScrollEdgeAppearance = appearance
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

