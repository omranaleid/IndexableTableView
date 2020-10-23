//
//  IndexCell.swift
//  IndexableTableView
//
//  Created by Omran Aleid on 2020-10-19.
//  Copyright © 2020 Omran Aleid. All rights reserved.
//

import UIKit

class IndexCell: UICollectionViewCell {
    static let id = "IndexCell"
    
    private var isCurrent = false {
        didSet {
            configureSelectIndicator()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(isCurrent: Bool, title: String) {
        self.isCurrent = isCurrent
        titleLabel.text = title
    }
}

private extension IndexCell {
    
    func configureUI() {
        backgroundColor = .clear
        
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        titleLabel.layer.borderColor = UIColor.black.cgColor
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.cornerRadius = 5
        titleLabel.backgroundColor = .white
        titleLabel.layer.masksToBounds = true
    }
    
    func configureSelectIndicator() {
        titleLabel.backgroundColor = isCurrent ? .systemRed : .white
    }
}
