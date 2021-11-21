//
//  ViewerTitleView.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import UIKit

class ViewerTitleView: UIView {
    var title: String {
        get { self.label.text ?? "" }
        set { self.label.text = newValue }
    }
    
    private let stackView: UIStackView = .init()
    private let label: UILabel = .init()
    private let leftButton: UIButton = .init()
    private let rightButton: UIButton = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension ViewerTitleView {
    func setup() {
        self.setupStackView(self.stackView)
        self.setupLeftButton(self.leftButton)
        self.setupLabel(self.label)
        self.setupRightButton(self.rightButton)
    }
    
    func setupStackView(_ stackView: UIStackView) {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setupLabel(_ label: UILabel) {
        self.stackView.addArrangedSubview(label)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .bold)
    }
    
    func setupLeftButton(_ button: UIButton) {
        self.stackView.addArrangedSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func setupRightButton(_ button: UIButton) {
        self.stackView.addArrangedSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
