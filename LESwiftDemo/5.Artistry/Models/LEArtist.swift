//
//  LEArtistry.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/19.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

struct LEArtist {
    let name : String
    let bio : String
    let image: UIImage
    var works: [LEWork]
    init(name: String, bio: String, image: UIImage, works: [LEWork]) {
        self.name = name
        self.bio = bio
        self.image = image
        self.works = works
    }
    static func artistsFromBundle() -> [LEArtist] {
        var artists = [LEArtist]()
        guard let url = Bundle.main.url(forResource: "artists", withExtension: ".json") else { return artists }
        do {
            let data = try Data(contentsOf: url)
            
            guard let rootObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return artists }
            guard let artistObjects = rootObject["artists"] as? [[String: AnyObject]] else { return artists }
            for artistObject in artistObjects {
                if let name = artistObject["name"] as? String,
                    let bio = artistObject["bio"] as? String,
                    let imageName = artistObject["image"] as? String,
                    let image = UIImage(named: imageName),
                    let worksObject = artistObject["works"] as? [[String: String]] {
                    var works = [LEWork]()
                    for workObject in worksObject {
                        if let workTitle = workObject["title"],
                        let workImageNmae = workObject["image"],
                        let workImage = UIImage(named: workImageNmae + ".jpg"),
                            let info = workObject["info"] {
                            works.append(LEWork(title: workTitle, image: workImage, info: info, isExpanded: false))
                        }
                    }
                    let artist = LEArtist(name: name, bio: bio, image: image, works: works)
                    artists.append(artist)
                }
            }
            
        } catch {
            return artists
        }
        return artists
    }
}
