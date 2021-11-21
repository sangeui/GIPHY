//
//  CollectionViewLayout.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/19.
//

import UIKit

class StaggeredGridLayout: UICollectionViewLayout {
    var onRequestImageHeight: ((IndexPath) -> CGFloat)? = nil
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private let columns: Int = 2
    private let lineSpacingBetweenItems: CGFloat = 4
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = self.collectionView else { return .zero }
        
        let contentInset = collectionView.contentInset
        
        return collectionView.bounds.width - (contentInset.left + contentInset.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return .init(width: self.contentWidth, height: self.contentHeight)
    }
    
    override public func invalidateLayout() {
        self.cache.removeAll()
        self.contentHeight = 0
        
        super.invalidateLayout()
    }
    
    override func prepare() {
        guard let collectionView = self.collectionView else { return }
        
        let columnWidth = self.contentWidth / CGFloat(self.columns)
        var horizontalOffset: [CGFloat] = []
        horizontalOffset.append(contentsOf: (0..<self.columns).map({ CGFloat($0) * columnWidth }))
        
        var verticalOffset: [CGFloat] = .init(repeating: .zero, count: self.columns)
        
        (0..<collectionView.numberOfItems(inSection: .zero)).forEach { item in
            // 이미지 높이 요청
            let indexPath: IndexPath = .init(item: item, section: .zero)
            let imageHeight = self.onRequestImageHeight?(indexPath) ?? 200
            
            // 반환된 이미지 높이로, 셀 간 간격을 포함한 전체 높이를 계산
            let height = self.lineSpacingBetweenItems * 2 + imageHeight
            
            // 어떤 칼럼에 채워질지 결정
            let column = verticalOffset.firstIndex(of: verticalOffset.min() ?? .zero) ?? .zero

            // 아이템이 그려질 프레임
            let frame = CGRect(x: horizontalOffset[column], y: verticalOffset[column], width: columnWidth, height: height)
            
            // 아이템 패딩
            let insetFrame = frame.insetBy(dx: self.lineSpacingBetweenItems, dy: self.lineSpacingBetweenItems)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attributes.frame = insetFrame
            self.cache.append(attributes)
            
            self.contentHeight = max(self.contentHeight, frame.maxY)
            verticalOffset[column] = verticalOffset[column] + height
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes: [UICollectionViewLayoutAttributes] = []
        
        self.cache.forEach { cachedAttributes in
            if cachedAttributes.frame.intersects(rect) {
                attributes.append(cachedAttributes)
            }
        }
        
        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cache[indexPath.item]
    }
}
