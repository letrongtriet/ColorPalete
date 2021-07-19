//
//  ColorPickerViewController.swift
//  ColorPickerViewController
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import UIKit

class ColorPickerViewController: UIViewController {
    var viewModel: ColorPickerViewModel!

    @IBOutlet weak var colorSlider: CustomSlider!
    @IBOutlet weak var tintSlider: CustomSlider!
    @IBOutlet weak var alphaSlider: CustomSlider!
    @IBOutlet weak var bottomView: UIView!

    lazy var colorSliderGradientLayer: CAGradientLayer = {
        let firstGradientLayer = CAGradientLayer()
        firstGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        firstGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return firstGradientLayer
    }()

    lazy var tintSliderGradientLayer: CAGradientLayer = {
        let secondGradientLayer = CAGradientLayer()
        secondGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        secondGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return secondGradientLayer
    }()

    lazy var alphaSliderGradientLayer: CAGradientLayer = {
        let thirdGradientLayer = CAGradientLayer()
        thirdGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        thirdGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return thirdGradientLayer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        addCornerRadius()
        bind()
        viewModel.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        colorSliderGradientLayer.frame = colorSlider.bounds
        colorSliderGradientLayer.cornerRadius = colorSlider.layer.cornerRadius

        tintSliderGradientLayer.frame = tintSlider.bounds
        tintSliderGradientLayer.cornerRadius = tintSlider.layer.cornerRadius

        alphaSliderGradientLayer.frame = alphaSlider.bounds
        alphaSliderGradientLayer.cornerRadius = alphaSlider.layer.cornerRadius
    }

    @IBAction func userDidTapSaveButton(_ sender: Any) {
        viewModel.userDidTapSaveButton()
    }

    private func setupUI() {
        title = "Create Palette"

        colorSlider.layer.insertSublayer(colorSliderGradientLayer, at: 0)
        colorSlider.setupInitialValue()

        tintSlider.layer.insertSublayer(tintSliderGradientLayer, at: 0)
        tintSlider.setupInitialValue()

        alphaSlider.layer.insertSublayer(alphaSliderGradientLayer, at: 0)
        alphaSlider.setupInitialValue()
    }

    private func addCornerRadius() {
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 16
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    private func bind() {
        colorSlider.colorCallback = { [weak self] color in
            self?.viewModel.mainColorDidChange(color)
        }

        tintSlider.colorCallback = { [weak self] color in
            self?.viewModel.colorDidChange(color)
        }

        alphaSlider.colorCallback = { [weak self] color in
            self?.viewModel.colorDidChange(color)
        }
    }
}
