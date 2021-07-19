//
//  HomeCoordinator.swift
//  HomeCoordinator
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import UIKit

final class HomeCoordinator {
    // MARK: - Private properties

    private let window: UIWindow
    private let localStorageService: LocalStorageInterface
    private let colorService: ColorService
    private let navigationController: UINavigationController

    // MARK: - Init

    init(
        window: UIWindow,
        localStorageService: LocalStorageInterface,
        colorService: ColorService
    ) {
        self.window = window
        self.localStorageService = localStorageService
        self.colorService = colorService

        navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Private methods
    private func showColorPaleteView() {
        let colorPaleteViewController = ColorPaleteViewController(
            nibName: ColorPaleteViewController.identifier(),
            bundle: nil
        )
        let viewModel = ColorPaleteViewModel(
            colorService: colorService,
            view: colorPaleteViewController,
            delegate: self,
            localStorageInterface: localStorageService
        )
        colorPaleteViewController.viewModel = viewModel
        navigationController.setViewControllers([colorPaleteViewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func showColorPickerView() {
        let colorPickerViewController = ColorPickerViewController(
            nibName: ColorPickerViewController.identifier(),
            bundle: nil
        )
        let viewModel = ColorPickerViewModel(
            colorService: colorService,
            view: colorPickerViewController,
            delegate: self,
            localStorageInterface: localStorageService
        )
        colorPickerViewController.viewModel = viewModel
        navigationController.pushViewController(colorPickerViewController, animated: true)
    }
}

extension HomeCoordinator: Coordinator {
    func start() {
        showColorPaleteView()
    }
}

extension HomeCoordinator: ColorPaleteViewModelDelegate {
    func showColorPicker() {
        showColorPickerView()
    }
}

extension HomeCoordinator: ColorPickerViewModelDelegate {

}
