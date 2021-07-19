//
//  CustomSlider.swift
//  CustomSlider
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import UIKit

class CustomSlider: UIView {
    var colorCallback: ((UIColor) -> Void)?

    private lazy var cursor: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private var leadingConstraint: NSLayoutConstraint?

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2
    }

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setupInitialValue() {
        leadingConstraint?.constant = bounds.width / 2
    }

    private func setupUI() {
        addSubview(cursor)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(panRecgonizer:)))
        addGestureRecognizer(panGesture)
        isUserInteractionEnabled = true

        setConstraints()
    }

    private func setConstraints() {
        cursor.translatesAutoresizingMaskIntoConstraints = false

        let leadingConstraint = cursor.leadingAnchor.constraint(equalTo: leadingAnchor)
        self.leadingConstraint = leadingConstraint

        NSLayoutConstraint.activate([
            leadingConstraint,
            cursor.heightAnchor.constraint(equalTo: heightAnchor),
            cursor.widthAnchor.constraint(equalToConstant: 5),
            cursor.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    @objc
    private func panGesture(panRecgonizer: UIPanGestureRecognizer) {
        let currentPoint = panRecgonizer.location(in: self)
        var x: CGFloat = 0
        if currentPoint.x >= (bounds.width - 5) {
            x = bounds.width - 5
        } else if currentPoint.x <= 5 {
            x = 5
        } else {
            x = currentPoint.x
        }
        leadingConstraint?.constant = x
        if panRecgonizer.state == .ended {
            let finalPoint = CGPoint(x: x, y: currentPoint.y)
            if let color = layer.sublayers?.first?.colorOfPoint(point: finalPoint) {
                colorCallback?(color)
            }
        }
    }
}
