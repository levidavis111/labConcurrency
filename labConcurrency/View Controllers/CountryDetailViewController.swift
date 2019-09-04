//
//  CountryDetailViewController.swift
//  labConcurrency
//
//  Created by Levi Davis on 9/3/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {
    
    var oneCountry: Country!

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCapitalLabel: UILabel!
    @IBOutlet weak var countryPopulationLabel: UILabel!
    @IBOutlet weak var countryCurrencyLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFlagImage()
        setupLabels()
        // Do any additional setup after loading the view.
    }
    

    private func setupLabels() {
        
        countryNameLabel.text = "Name: \(oneCountry.name)"
        countryCapitalLabel.text = "Capital: \(oneCountry.capital)"
        countryPopulationLabel.text = "Population: \(oneCountry.population)"
        countryCurrencyLabel.text = "Currency: \(oneCountry.currencies[0].code)"
        
    }
    
    private func loadFlagImage() {
        let urlStr = oneCountry.flag
        guard let url = URL(string: urlStr) else {return}
        DispatchQueue.global(qos: .userInitiated).async {
            do {let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    
                    self.flagImageView.image = image
                    
                }
                
            } catch {
                fatalError()
            }
        }
    }
    

}
