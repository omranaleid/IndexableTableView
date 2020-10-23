//
//  ViewController.swift
//  IndexableTableView
//
//  Created by Omran Aleid on 2020-10-19.
//  Copyright © 2020 Omran Aleid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var data: [TableSection] = DataProvider.IndexableData
    var isUpdating = false
    
    private lazy var indexView: IndexView = {
        let view = IndexView(data: data.map {$0.index})
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.separatorStyle = .none
        return table
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableView.reloadData()
    }
}

extension ViewController: IndexViewDelegate {
 
    func didSelect(index: String) {
        guard let wantedSection = data.firstIndex(where: {$0.index == index}) else { return }
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: wantedSection), at: .top, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodItemCell.id, for: indexPath) as? FoodItemCell else {
            return UITableViewCell()
        }
        cell.set(data: data[indexPath.section].rows[indexPath.row])
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = .white
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = data[section].title
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15).isActive = true
        return view
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard !isUpdating, tableView.isDragging else { return }
        
        guard let topVisableCell = tableView.visibleCells.first,
            let sectionForTopCell = tableView.indexPath(for: topVisableCell)?.section else {
                return
        }
        
        indexView.setSelected(section: sectionForTopCell)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(FoodItemCell.hight)
    }
}

private extension ViewController {
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(indexView)
        indexView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        indexView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        indexView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        indexView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: indexView.bottomAnchor).isActive = true
        
        configureTable()
    }
    
    func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FoodItemCell.self, forCellReuseIdentifier: FoodItemCell.id)
    }
}
