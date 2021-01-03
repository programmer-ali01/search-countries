//
//  Service.swift
//  countries-information
//
//  Created by Alisena Mudaber on 12/29/20.
//

import Foundation

final class Service {
    static let shared = Service()
    func fetchCountryData(onCompletion: @escaping ([Results]) -> ()) {
        let urlString = "https://restcountries.eu/rest/v2/"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("data was nil")
                return
            }
            
            guard let countryList = try? JSONDecoder().decode([Results].self, from: data) else {
                print("Couldn't decode json")
                return
            }
            onCompletion(countryList)
        }
        task.resume()
        
    }
}
