//
//  NavigationControllerAppearance+Extension.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 17.08.2023.
//

import UIKit.UINavigationController

extension UINavigationController {
    func setupNavigationController() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(hex: Colors.background)
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
    }
}
