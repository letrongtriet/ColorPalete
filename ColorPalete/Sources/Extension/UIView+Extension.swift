//
//  UIView+Extension.swift
//  UIView+Extension
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import UIKit

extension UIView {
    func scaleAnimation() {
        transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                           self.transform = CGAffineTransform.identity
                       },
                       completion: { _ in })
    }

    func showLoadingIndicator() {
        let containerView = UIView(frame: bounds)
        containerView.backgroundColor = UIColor.lightGray
        containerView.tag = 0xDEAD_BEEF
        containerView.layer.cornerRadius = layer.cornerRadius

        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.tintColor = UIColor.black
        loadingIndicator.startAnimating()

        containerView.addSubview(loadingIndicator)
        loadingIndicator.center = containerView.center
        addSubview(containerView)
        bringSubviewToFront(containerView)
    }

    func hideLoadingIndicator() {
        if let foundView = viewWithTag(0xDEAD_BEEF) {
            foundView.removeFromSuperview()
        }
    }
}
