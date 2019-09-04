//
//  CountryAPIClient.swift
//  labConcurrency
//
//  Created by Levi Davis on 9/3/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

struct CountryAPIClient {

    static let shared = CountryAPIClient()
    let urlStr = "https://restcountries.eu/rest/v2/name/united"

    enum FetchUserErrors: Error {
                case remoteResponseError
                case noDataError
                case badDecodeError
            }

            func fetchUsers(completionHandler: @escaping (Result<[Country],Error>) -> () ) {
                    guard let url = URL(string: urlStr) else {return}
                URLSession.shared.dataTask(with: url) { (data, response, error) in

                    guard error == nil else {completionHandler(.failure(FetchUserErrors.remoteResponseError))
                        return
                    }
                    guard let data = data else {completionHandler(.failure(FetchUserErrors.noDataError))
                        return
                    }
                    guard let country = Country.getCountries(from: data) else {completionHandler(.failure(FetchUserErrors.badDecodeError))
                        return
                    }
                    completionHandler(.success(country))
                    }.resume()
            }
}

