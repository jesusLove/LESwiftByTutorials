//
//  LEGoViewController.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/22.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
protocol PokemonSelectionDelegate: class  {
    func pokemonSelected(_ newPokemon: Pokemon)
}
class LEGoViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var pokemons = LibraryAPI.sharedInstance.getPokemons()
    var filterdPokemons = [Pokemon]()
    weak var delegate: PokemonSelectionDelegate?
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        filterdPokemons = pokemons
    }
    fileprivate func setupUI() {
        self.title = "精灵列表"
        searchBar.rx.text.subscribe(
            onNext: {[unowned self] query in
                if query?.count == 0 {
                    self.filterdPokemons = self.pokemons
                } else {
                    self.filterdPokemons = self.pokemons.filter{$0.name.hasPrefix(query!)}
                }
                self.tableView.reloadData()
        })
        .disposed(by:disposeBag)
    }

    // MARK: - Table view data source

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterdPokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goCell", for: indexPath) as! LEGoCell
        let pokemon = filterdPokemons[indexPath.row]
        cell.awakeFromNib(pokemon.id, name: pokemon.name, pokeImageUrl: pokemon.pokeImgUrl)
        
        return cell;
    }
    
}
