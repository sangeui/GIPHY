//
//  ViewerProfileView.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import UIKit

class ViewerProfileView: UIView {
    var onTouchLikeButton: ((Bool) -> Void)? = nil
    
    private let horizontalStackView: UIStackView = .init()
    private let sourceIconImageView: UIImageView = .init()
    private let labelStackView: LabelStackView = .init()
    private let primarySourceLabel: UILabel = .init()
    private let secondarySourceLabdel: UILabel = .init()
    private let likeButton: TintColorFlippableButton = .init(tintColorSet: .init(selected: .systemRed, deselected: .lightGray))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func source(text: String) {
        self.labelStackView.primaryText = text
    }
    
    func userNames(primary: String, secondary: String) {
        self.labelStackView.primaryText = primary
        self.labelStackView.secondaryText = secondary
    }
    
    func like(_ bool: Bool) {
        self.likeButton.isSelected = bool
    }
}

private extension ViewerProfileView {
    func setup() {
        self.setupHorizontalStackView(self.horizontalStackView)
        self.setupSourceIconImageView(self.sourceIconImageView)
        self.setupLabelStackView(self.labelStackView)
        
        self.setupLikeButton(self.likeButton)
    }
    
    func setupHorizontalStackView(_ stackView: UIStackView) {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        stackView.spacing = 4
    }
    
    func setupSourceIconImageView(_ imageView: UIImageView) {
        self.horizontalStackView.addArrangedSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        imageView.image = .init(systemName: "globe.americas.fill")

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = .darkGray
        imageView.tintColor = .white
    }
    
    func setupLabelStackView(_ stackView: LabelStackView) {
        self.horizontalStackView.addArrangedSubview(stackView)
        stackView.secondaryText = "Source"
        stackView.primaryText = "www.reactiongifs.com"
    }
    
    func setupLikeButton(_ button: TintColorFlippableButton) {
        self.horizontalStackView.addArrangedSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalTo: self.heightAnchor, constant: 5).isActive = true
        button.setImage(.init(systemName: "suit.heart.fill"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.imageEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        button.onTouch = { [weak self] in
            self?.onTouchLikeButton?(button.isSelected)
        }
    }
}
