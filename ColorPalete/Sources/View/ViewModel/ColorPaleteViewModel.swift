//
//  ColorPaleteViewModel.swift
//  ColorPaleteViewModel
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import Foundation

protocol ColorPaleteViewModelDelegate {
    func showColorPicker()
}

final class ColorPaleteViewModel {
    // MARK: - Private properties

    private let colorService: ColorService
    private let localStorageInterface: LocalStorageInterface
    private weak var view: ColorPaleteView?
    private var delegate: ColorPaleteViewModelDelegate?

    // MARK: - Init

    init(
        colorService: ColorService,
        view: ColorPaleteView?,
        delegate: ColorPaleteViewModelDelegate?,
        localStorageInterface: LocalStorageInterface
    ) {
        self.colorService = colorService
        self.view = view
        self.delegate = delegate
        self.localStorageInterface = localStorageInterface
    }

    // MARK: - Public methods
    func viewDidAppear() {
        guard let storageId = localStorageInterface.getStorageId() else {
            view?.showEmptyState(true)
            return
        }
        colorService.getColors(storageId: storageId) { [weak self] result in
            switch result {
            case .failure:
                if let colors = self?.localStorageInterface.getColors() {
                    self?.view?.showEmptyState(false)
                    self?.view?.updateView(with: colors)
                } else {
                    self?.view?.showEmptyState(true)
                }
            case let .success(response):
                let colors = Colors(
                    data: response.data,
                    id: response.id
                )
                self?.localStorageInterface.setColors(colors)
                self?.view?.showEmptyState(false)
                self?.view?.updateView(with: colors)
            }
        }
    }

    func userDidTapAddButton() {
        delegate?.showColorPicker()
    }
}
