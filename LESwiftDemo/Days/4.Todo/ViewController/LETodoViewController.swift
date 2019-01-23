//
//  LETodoViewController.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/17.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit
var todoItems : [LETodoItem] = []

class LETodoViewController: UIViewController {
    
    fileprivate let identifierCell = "todoCell"

    @IBOutlet weak var todoTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todoTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backBtn)
        navigationItem.leftBarButtonItem = editButtonItem
        title = "Todo List"
        todoItems = [
            LETodoItem(id: "1", image: "child-selected", title: "Go to Disney", date: Date.dateFormString("2014-10-20")),
            LETodoItem(id: "2", image: "shopping-cart-selected", title: "Cicso Shopping", date: Date.dateFormString("2014-10-28")),
            LETodoItem(id: "3", image: "phone-selected", title: "Phone to Jobs", date: Date.dateFormString("2014-10-30")),
            LETodoItem(id: "4", image: "travel-selected", title: "Plan to Europe", date: Date.dateFormString("2014-10-31"))
        ]
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editItem" {
            let vc = segue.destination as! LEDetailViewController
            if let indexPath = todoTableView.indexPathForSelectedRow {
                vc.todo = todoItems[indexPath.row]
            }
        }
    }
    
    
    var backBtn: UIButton = {
       let btn = UIButton(type: .custom)
        btn.setTitle("back", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        btn.backgroundColor = .yellow
        btn.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
        btn.frame = CGRect(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height - 100, width: 50, height: 50)
        return btn
    }()
    @objc func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension LETodoViewController: UITableViewDelegate {
    // 设置是否可以编辑
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        todoTableView.setEditing(editing, animated: true)
    }
    // 删除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 1. 从数组中删除
            todoItems.remove(at: indexPath.row)
            // 2. 删除Cell
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    // 能否移动
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    // 移动，更新数据
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = todoItems.remove(at: sourceIndexPath.row)
        todoItems.insert(item, at: destinationIndexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - UITableViewDataSource
extension LETodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = todoItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        
        if let imageView = cell.viewWithTag(11) as? UIImageView {
            imageView.image = UIImage(named: item.image)
        }
        if let titleLB = cell.viewWithTag(12) as? UILabel {
            titleLB.text = item.title
        }
        if let subTitleLB = cell.viewWithTag(13) as? UILabel {
            subTitleLB.text = item.date.dateToString()
        }
        
        return cell
    }
}
