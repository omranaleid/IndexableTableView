//
//  IndexView.swift
//  IndexableTableView
//
//  Created by Omran Aleid on 2020-10-19.
//  Copyright © 2020 Omran Aleid. All rights reserved.
//

import UIKit

protocol IndexViewDelegate: class {
    func didSelect(index: String)
}

class IndexView: UIView {
    
    private var data: [String] = ["Index1", "Index2", "Index3", "Index4", "Index5", "Index6"]
    private var selectedIndex = 0 {
        didSet {
            collectionView.reloadData()
            collectionView.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: .left, animated: true)
        }
    }
    
    weak var delegate: IndexViewDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsMultipleSelection = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    init(data: [String]) {
        super.init(frame: .zero)
        self.data = data
        configureUI()
    }
    
    func setSelected(section: Int) {
        selectedIndex = section
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension IndexView {
    
    func configureUI() {
        backgroundColor = .clear
        addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        configureCollection()
    }
    
    func configureCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IndexCell.self, forCellWithReuseIdentifier: IndexCell.id)
    }
}

extension IndexView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndexCell.id, for: indexPath) as? IndexCell else {
            return UICollectionViewCell()
        }
        cell.set(isCurrent: selectedIndex == indexPath.row, title: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        delegate?.didSelect(index: data[indexPath.row])
    }
}

extension IndexView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 40)
    }
}
