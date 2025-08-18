//
//  SceneDelegate.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 16.08.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        // Create tab bar controller
        let tabBarController = UITabBarController()
        
        // Configure tab bar appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .systemBackground
        
        // First Tab - Product List
        let productListVC = DependencyContainer.shared.resolveProductListViewController()
        let productListNav = UINavigationController(rootViewController: productListVC)
        productListNav.tabBarItem = UITabBarItem(
            title: "Products",
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet")
        )
        
        // Second Tab - Cart
        let cartNav = CartRouter.createCartModule()
        cartNav.tabBarItem = UITabBarItem(
            title: "Sepetim",
            image: UIImage(systemName: "cart"),
            selectedImage: UIImage(systemName: "cart.fill")
        )
        
        // Third Tab - Favorites (Placeholder for now)
        let favoritesVC = UIViewController()
        favoritesVC.view.backgroundColor = .systemBackground
        favoritesVC.title = "Favorites"
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        favoritesNav.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        // Fourth Tab - Profile (Placeholder for now)
        let profileVC = UIViewController()
        profileVC.view.backgroundColor = .systemBackground
        profileVC.title = "Profile"
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        // Configure tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground

        // Apply the appearance to tab bar
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().standardAppearance = appearance
        } else {
            UITabBar.appearance().standardAppearance = appearance
        }
        
        // Customize tab bar items
        UITabBarItem.appearance().setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 12, weight: .semibold)],
            for: .normal
        )
        
        // Set tint colors
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().unselectedItemTintColor = .systemGray
        
        // Set view controllers
        tabBarController.viewControllers = [productListNav,cartNav, favoritesNav, profileNav]
        
        // Make tab bar controller the root
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
