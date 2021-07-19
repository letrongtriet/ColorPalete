//
//  ColorCollectionViewCell.swift
//  ColorCollectionViewCell
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
    }

    func updateBackgroundColor(with hexString: String) {
        contentView.backgroundColor = UIColor(hex: hexString) ?? .black
        backgroundColor = UIColor(hex: hexString) ?? .black
    }
}
