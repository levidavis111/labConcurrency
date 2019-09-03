//
//  Country.swift
//  labConcurrency
//
//  Created by Levi Davis on 9/3/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let capital: String
    let population: Int
    let flag: String
    
    static func getCountries(from data: Data) -> [Country] {
        do {
            let countryResults = try JSONDecoder().decode([Country].self, from: data)
            return countryResults
        } catch let decodeError {
            fatalError("Error: \(decodeError)")
        }
    }
}


