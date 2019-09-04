//
//  CountryViewController.swift
//  labConcurrency
//
//  Created by Levi Davis on 9/3/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    var countryArray = [Country]() {
        didSet {
            countryTableView.reloadData()
        }
    }
    
    var searchString: String? = nil {
        didSet {
            countryTableView.reloadData()
        }
    }
    
    var searchResults: [Country] {
        get {
            guard let searchString = searchString else {return countryArray}
            guard searchString != "" else {return countryArray}
            
            return countryArray.filter{$0.name.lowercased().contains(searchString)}
        }
    }
    
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var countryTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CountryDetailViewController {
            guard let indexPath = countryTableView.indexPathForSelectedRow,
                let countryVC = segue.destination as? CountryDetailViewController else {return}
            let oneCountry = countryArray[indexPath.row]
            countryVC.oneCountry = oneCountry
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTableView.delegate = self
        countryTableView.dataSource = self
        searchBarOutlet.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        CountryAPIClient.shared.fetchUsers { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let countries):
                    self.countryArray = countries
                }
            }
        }
        
    }
}

extension CountryViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let oneCounty = searchResults[indexPath.row]
        cell.textLabel?.text = oneCounty.name
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text?.lowercased()
    }

}
