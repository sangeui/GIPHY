//
//  ViewerViewController.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import UIKit

class ViewerViewController: UIViewController {
    private let viewModel: ViewerViewModel
    
    init(viewModel: ViewerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        self.view = ViewerView(viewModel: self.viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
    }
}
