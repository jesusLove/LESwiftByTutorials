//
//  LEProductsTableViewController.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/16.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

class LEProductsTableViewController: UITableViewController {
    private var products: [LEProduct]?
    private var identifier = "productCell" // 这个ID和storyboard中的相同
    
    override func viewDidLoad() {
        super.viewDidLoad()
        products = [
            LEProduct(name: "1907 Wall Set", cellImageName: "image-cell1", fullscreenImageName: "phone-fullscreen1"),
            LEProduct(name: "1921 Dial Phone", cellImageName: "image-cell2", fullscreenImageName: "phone-fullscreen2"),
            LEProduct(name: "1937 Desk Set", cellImageName: "image-cell3", fullscreenImageName: "phone-fullscreen3"),
            LEProduct(name: "1984 Moto Portable", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4")
        ]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 过滤showProduct跳转到LEProductVC
        if segue.identifier == "showProduct" {
            if let cell =  sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell),let productVC = segue.destination as? LEProductViewController {
                productVC.product = products?[indexPath.row]
            }
        }
    }
    
    @IBAction func backHome(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension LEProductsTableViewController {
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard let products = products else { return cell }
        
        cell.textLabel?.text = products[indexPath.row].name
        if let imageName = products[indexPath.row].cellImageName {
            cell.imageView?.image = UIImage(named: imageName)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
}
