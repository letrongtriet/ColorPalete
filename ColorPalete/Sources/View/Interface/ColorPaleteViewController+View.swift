//
//  ColorPaleteViewController+View.swift
//  ColorPaleteViewController+View
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import Foundation

extension ColorPaleteViewController: ColorPaleteView {
    func updateView(with colors: Colors) {
        colorsString = colors.data
        collectionView.reloadData()
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        collectionViewHeightConstraint.constant = collectionView.contentSize.height
        view.layoutIfNeeded()
    }

    func showEmptyState(_ shouldShow: Bool) {
        firstTimeLabel.isHidden = !shouldShow
    }
}
