//
//  LEGoViewController.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/22.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

class LEGoViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
