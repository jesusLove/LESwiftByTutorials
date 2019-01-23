//
//  LEArtistryListViewController.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/19.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

class LEArtistryListViewController: UIViewController {
    let artists = LEArtist.artistsFromBundle()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backBtn)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        tableView.dataSource = self
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LEArtistryDetailController,
            let indexPath = tableView.indexPathForSelectedRow {
            destination.selectdArtist = artists[indexPath.row]
        }
    }
}
extension LEArtistryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as! LEArtistryListCell
        let artist = artists[indexPath.row]
        cell.bioLB.text = artist.bio
        cell.nameLB.text = artist.name
        cell.artistImageView.image = artist.image
        cell.selectionStyle = .none
        return cell
    }
}
