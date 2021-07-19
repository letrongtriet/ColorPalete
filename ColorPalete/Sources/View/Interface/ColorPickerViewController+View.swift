//
//  ColorPickerViewController+View.swift
//  ColorPickerViewController+View
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import UIKit

extension ColorPickerViewController: ColorPickerView {
    func updateView(color: UIColor) {
        view.backgroundColor = color
    }

    func setupInitialView(colors: [CGColor], tintColors: [CGColor], alphaColors: [CGColor]) {
        colorSliderGradientLayer.colors = colors
        tintSliderGradientLayer.colors = tintColors
        alphaSliderGradientLayer.colors = alphaColors
    }

    func updateTintAndAlphaColors(tintColors: [CGColor], alphaColors: [CGColor]) {
        tintSliderGradientLayer.colors = tintColors
        alphaSliderGradientLayer.colors = alphaColors
    }

    func showError(errorMessage: String) {
        showAlert(
            title: nil,
            message: errorMessage,
            action: nil
        )
    }

    func showSuccessfulAlert() {
        showAlert(
            title: "Congratulation!",
            message: "You just added a new color to the palette",
            action: nil
        )
    }

    func showLoading(_ shouldShow: Bool) {
        shouldShow ? view.showLoadingIndicator() : view.hideLoadingIndicator()
    }
}
