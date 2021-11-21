//
//  RecentSearchesCell.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import UIKit

class RecentSearchesCell: UITableViewCell {
    var data: [String] = [] {
        didSet { self.collectionView.reloadData() }
    }
    
    var onTouchCell: ((String) -> Void)? = nil
    
    private let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension RecentSearchesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? RecentSearchQueryCell
        cell?.text = self.data[indexPath.row]
        
        return cell ?? .init()
    }
}

extension RecentSearchesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onTouchCell?(self.data[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.data[indexPath.row].size(withAttributes: [.font: UIFont.systemFont(ofSize: 15, weight: .bold)]).width + 30
        return .init(width: width, height: 30)
    }
}

private extension RecentSearchesCell {
    func setup() {
        self.setupCollectionView(self.collectionView)
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    func setupCollectionView(_ collectionView: UICollectionView) {
        self.contentView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        collectionView.register(RecentSearchQueryCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        collectionView.showsHorizontalScrollIndicator = false
    }
}

class RecentSearchQueryCell: UICollectionViewCell {
    var text: String {
        get { return self.label.text ?? "" }
        set { self.label.text = newValue }
    }
    
    private let label: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    override func prepareForReuse() {
        self.label.text = ""
    }
}

extension RecentSearchQueryCell {
    func setup() {
        self.backgroundColor = .darkGray
        self.setupLabel(self.label)
    }
    
    func setupLabel(_ label: UILabel) {
        self.contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4).isActive = true
        label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4).isActive = true
        label.font = .systemFont(ofSize: 15, weight: .bold)
        
        label.numberOfLines = 1
        label.textColor = .white
    }
}
