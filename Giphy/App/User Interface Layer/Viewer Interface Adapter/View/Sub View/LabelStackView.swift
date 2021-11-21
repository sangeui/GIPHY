//
//  LabelStackView.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import UIKit

class LabelStackView: UIStackView {
    var primaryText: String {
        get { return self.primaryLabel.text ?? "" }
        set { self.primaryLabel.text = newValue }
    }
    
    var secondaryText: String {
        get { return self.secondaryLabel.text ?? "" }
        set { self.secondaryLabel.text = newValue }
    }
    
    private let primaryLabel: UILabel = .init()
    private let secondaryLabel: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

private extension LabelStackView {
    func setup() {
        self.axis = .vertical
        self.setupSecondaryLabel(self.secondaryLabel)
        self.setupPrimaryLabel(self.primaryLabel)
    }
    
    func setupPrimaryLabel(_ label: UILabel) {
        self.addArrangedSubview(label)
        label.font = .systemFont(ofSize: 16, weight: .heavy)
    }
    
    func setupSecondaryLabel(_ label: UILabel) {
        self.addArrangedSubview(label)
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemGray3
    }
}
