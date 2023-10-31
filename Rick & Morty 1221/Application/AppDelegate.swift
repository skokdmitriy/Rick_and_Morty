//
//  AppDelegate.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 17.08.2023.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = CharactersAssembly.createModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setupNavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
