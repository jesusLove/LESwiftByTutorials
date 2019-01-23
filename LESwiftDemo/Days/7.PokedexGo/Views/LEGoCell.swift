//
//  LEGoCell.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/23.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

class LEGoCell: UITableViewCell {

    @IBOutlet weak var idLB: UILabel!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!
    
    fileprivate var indicator: UIActivityIndicatorView!
    func awakeFromNib(_ id: Int, name: String, pokeImageUrl: String) {
        super.awakeFromNib()
        setupUI(id, name: name)
        setupNotification(pokeImageUrl)
    }
    deinit {
        pokeImageView.removeObserver(self, forKeyPath: "image")
    }
    fileprivate func setupNotification(_ pokeImageUrl: String) {
        NotificationCenter.default.post(name: Notification.Name(downloadImageNotification), object: self, userInfo: ["pokeImageView": pokeImageView, "pokeImageUrl": pokeImageUrl])
    }
    fileprivate func setupUI(_ id: Int, name: String) {
        idLB.text = NSString(format: "#%03d", id) as String
        nameLB.text = name
        pokeImageView.image = UIImage(named: "default_img")
        indicator = UIActivityIndicatorView()
        indicator.center = CGPoint(x: pokeImageView.bounds.midX, y: pokeImageView.bounds.midY)
        indicator.style = .whiteLarge
        indicator.startAnimating()
        pokeImageView.addSubview(indicator)
        pokeImageView.addObserver(self, forKeyPath: "image", options: [], context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "image" {
            indicator.stopAnimating()
        }
    }
}
