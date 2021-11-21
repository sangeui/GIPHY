//
//  TrendingSearchesCell.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import UIKit

class TrendingSearchesCell: UITableViewCell {
    var terms: [String] = [] {
        didSet { self.termsDidUpdate(self.terms) }
    }
    
    var onTouchCell: ((String) -> Void)? = nil
    
    private let tableView: SelfResizingTableView = .init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.onTouchCell = nil
    }
}

extension TrendingSearchesCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.terms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let string = NSMutableAttributedString(string: "  \(self.terms[indexPath.row].capitalized)", attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .bold)])
        string.insert(.createStringFrom(systemImage: "line.diagonal.arrow", color: .systemTeal), at: .zero)
        
        cell.textLabel?.attributedText = string
        cell.selectionStyle = .none
        
        return cell
    }
}

extension TrendingSearchesCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onTouchCell?(self.terms[indexPath.row])
    }
}

private extension TrendingSearchesCell {
    func termsDidUpdate(_ terms: [String]) {
        self.tableView.reloadData()
    }
}

private extension TrendingSearchesCell {
    func setup() {
        self.setupTableView(self.tableView)
    }
    
    func setupTableView(_ tableView: UITableView) {
        self.contentView.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension NSAttributedString {
    static func createStringFrom(systemImage: String, color: UIColor) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = .init(systemName: systemImage, withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 13, weight: .regular)))?.withTintColor(color)
        
        return .init(attachment: attachment)
    }
}

class SelfResizingTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
        }
    }
    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
}
