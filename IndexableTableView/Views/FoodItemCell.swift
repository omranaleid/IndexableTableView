//
//  FoodItemCell.swift
//  IndexableTableView
//
//  Created by Omran Aleid on 2020-10-21.
//  Copyright © 2020 Omran Aleid. All rights reserved.
//

import UIKit

class FoodItemCell: UITableViewCell {
    
    static let id = "FoodItemCell"
    static let hight = 200
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var itemDescLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(data: FoodItem) {
        itemDescLabel.text = data.desc
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        itemPriceLabel.text = formatter.string(from: NSNumber(value: data.price))
        itemImage.image = data.image
        itemNameLabel.text = data.name
    }
}

private extension FoodItemCell {
    
    func configureUI() {
        selectionStyle = .none
        
        addSubview(container)
        container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        container.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true

        container.addSubview(itemImage)
        itemImage.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        itemImage.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        itemImage.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        itemImage.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true

        container.addSubview(infoContainer)
        infoContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        infoContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        infoContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        infoContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        infoContainer.addSubview(itemPriceLabel)
        itemPriceLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor).isActive = true
        itemPriceLabel.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 10).isActive = true
        itemPriceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        itemPriceLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true

        infoContainer.addSubview(itemNameLabel)
        itemNameLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 5).isActive = true
        itemNameLabel.trailingAnchor.constraint(equalTo: itemPriceLabel.leadingAnchor, constant: -5).isActive = true
        itemNameLabel.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 10).isActive = true

        infoContainer.addSubview(itemDescLabel)
        itemDescLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 5).isActive = true
        itemDescLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor).isActive = true
        itemDescLabel.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -5).isActive = true
        itemDescLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 10).isActive = true
    }
}
