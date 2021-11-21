//
//  SearchResultView.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import UIKit

class SearchResultView: UICollectionView {
    var data: [ImageProviderImage] = [] {
        didSet { self.reloadData() }
    }
    
    var onTouchItemAt: ((Int) -> Void)? = nil
    var onReachedScrollBottom: (() -> Void)? = nil
    
    private let staggeredGridLayout = StaggeredGridLayout()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: self.staggeredGridLayout)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: UICollectionView Data Source
extension SearchResultView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SearchResultCollectionViewCell
        cell?.load(gif: self.data[indexPath.row].thumbnail)

        return cell ?? .init()
    }
}

// MARK: - UICollectionView Delegate
extension SearchResultView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onTouchItemAt?(indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isReachedAtBottom {
            self.onReachedScrollBottom?()
        }
    }
}

private extension SearchResultView {
    func setup() {
        self.staggeredGridLayout.onRequestImageHeight = { [weak self] indexPath in
            guard let self = self else { return .zero }
            
            let image = self.data[indexPath.row]
            let scale = CGFloat(image.width) / (self.contentWidth / 2)
            
            return .init(image.height) * scale
        }
        
        self.delegate = self
        self.dataSource = self
        self.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
}

private extension UICollectionView {
    var boundsWidth: CGFloat { return self.bounds.width }
    var leftContentInset: CGFloat { return self.contentInset.left }
    var rightContentInset: CGFloat { return self.contentInset.right }
    var horizontalContentInset: CGFloat {
        return self.leftContentInset + self.rightContentInset
    }
    
    var contentWidth: CGFloat {
        return self.boundsWidth - self.horizontalContentInset
    }
}


private extension UIScrollView {
    var isReachedAtBottom: Bool {
        return (self.contentOffset.y >= (self.contentSize.height - self.frame.size.height).rounded(.down))
    }
}
