//
//  ColorPickerViewModel.swift
//  ColorPickerViewModel
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import Foundation
import UIKit

protocol ColorPickerViewModelDelegate {

}

final class ColorPickerViewModel {
    // MARK: - Private properties

    private let colorService: ColorService
    private let localStorageInterface: LocalStorageInterface
    private weak var view: ColorPickerView?
    private var delegate: ColorPickerViewModelDelegate?

    private lazy var colors: [UIColor] = [
        UIColor.red,
        UIColor.orange,
        UIColor.yellow,
        UIColor.green,
        UIColor.cyan,
        UIColor.blue,
        UIColor.purple
    ]

    lazy var cgColors = colors.map(\.cgColor)

    private var currentColor = UIColor.cyan
    private var currentTintPercent: CGFloat = 0.5
    private var currentAlphaPercent: CGFloat = 0.5

    // MARK: - Init

    init(
        colorService: ColorService,
        view: ColorPickerView?,
        delegate: ColorPickerViewModelDelegate?,
        localStorageInterface: LocalStorageInterface
    ) {
        self.colorService = colorService
        self.view = view
        self.delegate = delegate
        self.localStorageInterface = localStorageInterface
    }

    func viewDidLoad() {
        view?.updateView(color: currentColor)

        let darkerColor = currentColor.adjust(by: -50) ?? currentColor
        let lighterColor = currentColor.adjust(by: 50) ?? currentColor
        let zeroAlpha = UIColor.white
        let halfAlpha = currentColor.withAlphaComponent(0.5)
        let fullAlpha = currentColor.withAlphaComponent(1)
        view?.setupInitialView(
            colors: cgColors,
            tintColors: [darkerColor.cgColor, lighterColor.cgColor],
            alphaColors: [zeroAlpha.cgColor, halfAlpha.cgColor , fullAlpha.cgColor]
        )
    }

    func mainColorDidChange(_ color: UIColor) {
        currentColor = color
        let darkerColor = currentColor.adjust(by: -50) ?? currentColor
        let lighterColor = currentColor.adjust(by: 50) ?? currentColor
        let zeroAlpha = UIColor.white
        let halfAlpha = currentColor.withAlphaComponent(0.5)
        let fullAlpha = currentColor.withAlphaComponent(1)
        view?.updateView(color: currentColor)
        view?.updateTintAndAlphaColors(
            tintColors: [darkerColor.cgColor, lighterColor.cgColor],
            alphaColors: [zeroAlpha.cgColor, halfAlpha.cgColor , fullAlpha.cgColor]
        )
    }

    func colorDidChange(_ color: UIColor) {
        currentColor = color
        view?.updateView(color: currentColor)
    }

    func userDidTapSaveButton() {
        guard let hextString = currentColor.toHex else {
            view?.showError(errorMessage: "Color cannot be used at the moment")
            return
        }

        var currentColorStrings = localStorageInterface.getColors()?.data ?? []
        currentColorStrings.append(hextString)

        view?.showLoading(true)

        if let storageId = localStorageInterface.getStorageId() {
            let request = ColorCreationRequest(data: currentColorStrings)
            colorService.addColor(
                request: request,
                storageId: storageId
            ) { [weak self] result in
                self?.view?.showLoading(false)

                switch result {
                case .failure:
                    self?.view?.showError(errorMessage: "Oops! Something wrong happened! Try again later")
                case let .success(response):
                    let colors = Colors(
                        data: response.data,
                        id: response.id
                    )
                    self?.localStorageInterface.setColors(colors)
                    self?.view?.showSuccessfulAlert()
                }
            }
        } else {
            let request = ColorCreationRequest(data: currentColorStrings)
            colorService.createStorage(request: request) { [weak self] result in
                self?.view?.showLoading(false)

                switch result {
                case .failure:
                    self?.view?.showError(errorMessage: "Oops! Something wrong happened! Try again later")
                case let .success(response):
                    let colors = Colors(
                        data: response.data,
                        id: response.id
                    )
                    self?.localStorageInterface.setColors(colors)
                    self?.localStorageInterface.setStorageId(response.id)
                    self?.view?.showSuccessfulAlert()
                }
            }
        }
    }
}
