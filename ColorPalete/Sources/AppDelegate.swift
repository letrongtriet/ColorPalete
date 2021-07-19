//
//  AppDelegate.swift
//  ColorPalete
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        appCoordinator = AppCoordinator(
            window: window!,
            localStorageService: LocalStorageImpl()
        )
        appCoordinator.start()
        return true
    }
}
