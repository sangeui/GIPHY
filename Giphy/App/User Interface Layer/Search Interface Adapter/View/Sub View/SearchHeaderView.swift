//
//  SearchHeaderView.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import UIKit

class SearchHeaderView: UIView {
    var onDidBeginSearch: ((String) -> Void)? = nil
    var onDidEndSearch: ((String) -> Void)? = nil
    var onDidChangeSearchQuery: ((String) -> Void)? = nil
    var onSearchButtonClicked: ((String) -> Void)? = nil
    var onDidChangeSegmentedValue: ((String, Int) -> Void)? = nil
    
    var searchQuery: String {
        get { self.searchBar.text ?? "" }
        set { self.searchBar.text = newValue }
    }
    
    private let label: UILabel = .init()
    private let stackView: UIStackView = .init()
    private let searchBar: UISearchBar = .init()
    private let button: UIButton = .init()
    private let segmentedControlStackView: UIStackView = .init()
    private let segmentedContol: UISegmentedControl = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension SearchHeaderView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.onDidBeginSearch?(searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.onDidChangeSearchQuery?(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.onSearchButtonClicked?(searchBar.text ?? "")
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.onDidEndSearch?(searchBar.text ?? "")
    }
}

private extension SearchHeaderView {
    @objc func buttonDidTouch() {
        self.onSearchButtonClicked?(self.searchBar.text ?? "")
        self.searchBar.resignFirstResponder()
    }
    
    @objc func segmentedControlValueDidChange() {
        self.onDidChangeSegmentedValue?(self.searchBar.text ?? "", self.segmentedContol.selectedSegmentIndex)
    }
}

private extension SearchHeaderView {
    func setup() {
        self.setupLabel(self.label)
        self.setupStackView(self.stackView)
        self.setupSearchBar(self.searchBar)
        self.setupButton(self.button)
        self.setupSegmentedControlStackView(self.segmentedControlStackView)
        self.setupSegmentedControl(self.segmentedContol)
    }
    
    func setupLabel(_ label: UILabel) {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        label.text = "Search"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
    }
    
    func setupStackView(_ stackView: UIStackView) {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        stackView.topAnchor.constraint(equalTo: self.label.bottomAnchor).isActive = true

        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func setupSearchBar(_ searchBar: UISearchBar) {
        self.stackView.addArrangedSubview(searchBar)
        searchBar.placeholder = "Search GIPHY"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.searchTextField.clearButtonMode = .whileEditing
    }
    
    func setupButton(_ button: UIButton) {
        self.stackView.addArrangedSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.setImage(.init(systemName: "magnifyingglass"), for: .normal)
        
        button.addTarget(self, action: #selector(self.buttonDidTouch), for: .touchUpInside)
    }
    
    func setupSegmentedControlStackView(_ stackView: UIStackView) {
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        stackView.axis = .vertical
    }
    
    func setupSegmentedControl(_ segmentedControl: UISegmentedControl) {
        self.segmentedControlStackView.addArrangedSubview(segmentedControl)
        segmentedControl.insertSegment(withTitle: "GIFs", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Stickers", at: 1, animated: true)
        
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(self.segmentedControlValueDidChange), for: .valueChanged)
    }
}
