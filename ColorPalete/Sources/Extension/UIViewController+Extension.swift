//
//  UIViewController+Extension.swift
//  UIViewController+Extension
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, action: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: action
        )
        alert.addAction(okAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}
