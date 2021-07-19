//
//  ColorPaleteViewController.swift
//  ColorPaleteViewController
//
//  Created by Triet M1 Macbook Pro on 19.7.2021.
//

import UIKit

class ColorPaleteViewController: UIViewController {
    // MARK: - Dependencies

    var viewModel: ColorPaleteViewModel!

    // MARK: - IBOutlets

    @IBOutlet weak var firstTimeLabel: UILabel!
    @IBOutlet weak var addButtonImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!

    var colorsString = [String]()

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        addTapGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.viewDidAppear()
    }

    // MARK: - Private methods
    private func setupUI() {
        title = "Your Palettes"

        ColorCollectionViewCell.registerNib(in: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(logout))
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTapAddButton))
        addButtonImageView.isUserInteractionEnabled = true
        addButtonImageView.addGestureRecognizer(tapGesture)
    }

    @objc
    private func userDidTapAddButton() {
        addButtonImageView.scaleAnimation()
        viewModel.userDidTapAddButton()
    }

    @objc
    private func logout() {
        viewModel.userDidTapLogout()
    }
}

extension ColorPaleteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colorsString.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ColorCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.updateBackgroundColor(with: colorsString[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 4
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  8
    }
}
