//
//  LEPhotoRootViewController.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/23.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

private let reuseIdentifier = "photoCell"

class LEPhotoRootViewController: UICollectionViewController {
    fileprivate let sectionInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    fileprivate let photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LEPhotoCell
        cell.photoImageView.image = UIImage(named: photos[indexPath.row])
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
extension LEPhotoRootViewController: UICollectionViewDelegateFlowLayout {
    // Item尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}
