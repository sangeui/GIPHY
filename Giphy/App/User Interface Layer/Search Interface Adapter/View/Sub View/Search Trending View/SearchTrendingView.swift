//
//  SearchTrendingView.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import UIKit

class SearchTrendingView: UITableView {
    var source: [[String]] = [[]] {
        didSet { self.reloadData() }
    }
    
    var onTouchTrendingTerm: ((String) -> Void)? = nil
    var onTouchHistoryQuery: ((String) -> Void)? = nil
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .none
        self.register(TrendingSearchesCell.self, forCellReuseIdentifier: "TrendingSearchesCell")
        self.register(RecentSearchesCell.self, forCellReuseIdentifier: "RecentSearchesCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension SearchTrendingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 44
        }
    }
}

extension SearchTrendingView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.source.filter({ $0.isEmpty == false }).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < self.source.count else { return .zero }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Trending Searches" }
        else if section == 1 { return "Recent Searches" }
        else { return nil }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case .zero:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingSearchesCell", for: indexPath) as? TrendingSearchesCell
            cell?.terms = self.source[indexPath.section]
            cell?.onTouchCell = { [weak self] text in
                self?.onTouchTrendingTerm?(text)
            }
            return cell ?? .init()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchesCell", for: indexPath) as? RecentSearchesCell
            cell?.data = self.source[indexPath.section]
            cell?.onTouchCell = { [weak self] text in
                self?.onTouchHistoryQuery?(text)
            }
            
            return cell ?? .init()
        default:
            return .init()
        }
    }
}


