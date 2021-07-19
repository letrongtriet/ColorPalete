//
//  AppCoordinator.swift
//  AppCoordinator
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import UIKit

class AppCoordinator {
    // MARK: - Private properties

    private let window: UIWindow
    private let localStorageService: LocalStorageInterface

    private var homeCoordinator: HomeCoordinator?

    // MARK: - Init

    init(
        window: UIWindow,
        localStorageService: LocalStorageInterface
    ) {
        self.window = window
        self.localStorageService = localStorageService
    }

    // MARK: - Private methods
    private func showHome() {
        homeCoordinator = .init(
            window: window,
            localStorageService: localStorageService,
            colorService: ColorServiceImpl(
                baseUrlString: AppConfig.baseUrlString,
                localStorageService: localStorageService
            )
        )
        homeCoordinator?.start()
    }
}

// MARK: - Coordinator

extension AppCoordinator: Coordinator {
    func start() {
        showHome()
    }
}
