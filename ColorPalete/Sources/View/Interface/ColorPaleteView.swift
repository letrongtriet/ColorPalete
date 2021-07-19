//
//  ColorPaleteView.swift
//  ColorPaleteView
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import Foundation

protocol ColorPaleteView: AnyObject {
    func updateView(with colors: Colors)
    func showEmptyState(_ shouldShow: Bool)
    func userDidLogout()
}
