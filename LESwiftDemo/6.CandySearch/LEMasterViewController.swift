//
//  LEMasterViewController.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/21.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

class LEMasterViewController: UITableViewController {
    
    let searchVC = UISearchController(searchResultsController: nil)
    var candies = [Candy]()
    var filteredCandies = [Candy]()
    override func viewDidLoad() {
        super.viewDidLoad()
        candies = [
            Candy(category:"Chocolate", name:"Chocolate Bar"),
            Candy(category:"Chocolate", name:"Chocolate Chip"),
            Candy(category:"Chocolate", name:"Dark Chocolate"),
            Candy(category:"Hard", name:"Lollipop"),
            Candy(category:"Hard", name:"Candy Cane"),
            Candy(category:"Hard", name:"Jaw Breaker"),
            Candy(category:"Other", name:"Caramel"),
            Candy(category:"Other", name:"Sour Chew"),
            Candy(category:"Other", name:"Gummi Bear")
        ]
        setupSearchViewController()
    }
    func setupSearchViewController() {
        // 负责更新搜索结果的代理, 需要遵循 UISearchResultsUpdating 协议
        searchVC.searchResultsUpdater = self
        // 当搜索框激活时, 是否添加一个透明视图
        searchVC.dimsBackgroundDuringPresentation = false // 会添加一层蒙板
        definesPresentationContext = true
        searchVC.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        searchVC.searchBar.delegate = self
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchVC
            self.navigationItem.searchController?.isActive = true
            self.navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchVC.searchBar
        }
    }
    func filterContentForSearchText(_ searchText: String, scop: String = "All") {
        filteredCandies = candies.filter{ candy in
            if !(candy.category == scop) && scop != "All" {
                return false
            }
            return candy.name.lowercased().contains(searchText.lowercased()) || searchText == ""
        }
        tableView.reloadData()
    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchVC.isActive {
            return filteredCandies.count
        }
        return candies.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var candy: Candy
        if searchVC.isActive {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category
        return cell
    }
}
extension LEMasterViewController: UISearchResultsUpdating {
    // 更新
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scop: scope)
    }
}
extension LEMasterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scop: searchBar.scopeButtonTitles![selectedScope])
    }
}
