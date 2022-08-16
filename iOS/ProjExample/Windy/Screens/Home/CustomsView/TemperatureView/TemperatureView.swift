//
//  CustomTemperatureView.swift
//  WeatherApp
//
//  Created by Rin Sang on 14/07/2022.
//

import UIKit
import MUIComponents

final class TemperatureView: ParentView {

    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var collectionView: UICollectionView!

    let viewModel: TemperatureViewModelType = TemperatureViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configCollectionView() {
        collectionView.register(
            UINib(nibName: "TemporaryCollectionCell", bundle: nil),
            forCellWithReuseIdentifier: "TemporaryCollectionCell"
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
    }

    private func configView() {
        configCollectionView()
        pageControl.layer.cornerRadius = 5
    }

    @IBAction private func pageControlValueChane(_ sender: UIPageControl) {
        let item = sender.currentPage
        let indexPath = IndexPath(item: item, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension TemperatureView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemporaryCollectionCell", for: indexPath)
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
}

extension TemperatureView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
         CGSize(width: UIScreen.main.bounds.width, height: collectionView.bounds.height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}
