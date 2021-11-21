//
//  ViewController.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/19.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private let viewModel: SearchViewModel
    private var anyCancellableSet = Set<AnyCancellable>()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        self.view = SearchView(viewModel: self.viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindToOpenViewer()
        self.viewModel.readTrendingTerms()
        self.viewModel.readHistory()
    }
}

private extension ViewController {
    func bindToOpenViewer() {
        self.viewModel.openViewer.eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink { image in
                let viewModel = ViewerViewModel(image: image)
                let viewController = ViewerViewController(viewModel: viewModel)
                
                self.present(viewController, animated: true, completion: nil)
            }
            .store(in: &self.anyCancellableSet)
    }
}
