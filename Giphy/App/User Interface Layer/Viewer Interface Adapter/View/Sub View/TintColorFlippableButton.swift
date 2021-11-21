//
//  TintColorFlipableButton.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import UIKit

class TintColorFlippableButton: UIButton {
    var onTouch: (() -> Void)? = nil
    
    private let tintColorSet: TintColorSet
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.tintColor = self.tintColorSet.selected
            } else {
                self.tintColor = self.tintColorSet.deselected
            }
        }
    }
    
    init(tintColorSet: TintColorSet) {
        self.tintColorSet = tintColorSet
        super.init(frame: .zero)
        self.tintColor = tintColorSet.deselected
        self.addTarget(self, action: #selector(self.buttonDidTouch), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TintColorFlippableButton {
    struct TintColorSet {
        let selected: UIColor
        let deselected: UIColor
    }
}

private extension TintColorFlippableButton {
    @objc func buttonDidTouch() {
        self.isSelected.toggle()
        self.onTouch?()
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

