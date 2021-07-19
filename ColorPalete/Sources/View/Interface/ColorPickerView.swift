//
//  ColorPickerView.swift
//  ColorPickerView
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import UIKit

protocol ColorPickerView: AnyObject {
    func updateView(color: UIColor)
    func setupInitialView(colors: [CGColor], tintColors: [CGColor], alphaColors: [CGColor])
    func updateTintAndAlphaColors(tintColors: [CGColor], alphaColors: [CGColor])
    func showError(errorMessage: String)
    func showSuccessfulAlert()
    func showLoading(_ shouldShow: Bool)
}
