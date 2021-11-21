//
//  ViewerView.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import UIKit

class ViewerView: UIView {
    private let viewModel: ViewerViewModel
    
    private let titleView: ViewerTitleView = .init()
    private let profileView: ViewerProfileView = .init()
    private let scrollView: UIScrollView = .init()
    private let stackView: UIStackView = .init()
    private let imageView: UIImageView = .init()
    
    private let loader = GIFLoader()
    
    init(viewModel: ViewerViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.layer.cornerRadius = self.bounds.height * 0.01
    }
}

private extension ViewerView {
    func setup() {
        self.setupTitleView(self.titleView)
        self.setupScrollView(self.scrollView)
        self.setupStackView(self.stackView)
        self.setupImageView(self.imageView)
        self.setupProfileView(self.profileView)
        
        self.profileView.onTouchLikeButton = { [weak self] isSelected in
            self?.viewModel.userDidTouchFavorite(isSelected)
        }
    }
    
    func setupTitleView(_ view: ViewerTitleView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        view.title = "GIF"
    }
    
    func setupScrollView(_ scrollView: UIScrollView) {
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupStackView(_ stackView: UIStackView) {
        self.scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.trailingAnchor, constant: -20).isActive = true
        stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.heightAnchor).isActive = true
        
        stackView.axis = .vertical
    }
    
    func setupImageView(_ imageView: UIImageView) {
        self.stackView.addArrangedSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 500).isActive = true
        
        self.loader.load(urlString: self.viewModel.url?.absoluteString) { images in
            DispatchQueue.main.async {
                self.imageView.animationImages = images
                self.imageView.startAnimating()
            }
        }
        
        imageView.backgroundColor = .black.withAlphaComponent(0.05)
        imageView.clipsToBounds = true
        
        self.stackView.setCustomSpacing(8, after: imageView)
    }
    
    func setupProfileView(_ view: ViewerProfileView) {
        self.stackView.addArrangedSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.like(self.viewModel.isFavoriteContent)
        
        let userNames = self.viewModel.profileNames
        view.userNames(primary: userNames.primary, secondary: userNames.secondary)
    }
}
