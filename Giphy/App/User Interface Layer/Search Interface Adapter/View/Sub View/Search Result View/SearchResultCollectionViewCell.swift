//
//  CollectionViewCell.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = .init()
    private let loader = GIFLoader()
    
    override var isSelected: Bool {
        get { super.isSelected }
        set { }
    }
    
    override var isHighlighted: Bool {
        get { super.isHighlighted}
        set { }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.contentView.bounds.width * 0.05
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.loader.cancel()
        self.imageView.stopAnimating()
        self.imageView.animationImages = nil
        self.imageView.image = nil
        self.backgroundColor = .init(red: .random(in: 0...255) / 255,
                                                 green: .random(in: 0...255) / 255,
                                                 blue: .random(in: 0...255) / 255, alpha: 1)
    }
    
    func load(gif: String?) {
        self.imageView.stopAnimating()
        self.imageView.animationImages = nil
        self.loader.load(urlString: gif) { images in
            DispatchQueue.main.async {
                self.imageView.animationImages = images
                self.imageView.startAnimating()
            }
        }
    }
}

private extension SearchResultCollectionViewCell {
    func setup() {
        self.backgroundColor = .init(red: .random(in: 0...255) / 255,
                                                 green: .random(in: 0...255) / 255,
                                                 blue: .random(in: 0...255) / 255, alpha: 1)
        self.clipsToBounds = true
        self.setupImageView(self.imageView)
    }
    
    func setupImageView(_ imageView: UIImageView) {
        self.contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        imageView.isUserInteractionEnabled = false
    }
}
