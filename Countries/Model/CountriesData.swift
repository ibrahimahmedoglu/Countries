//
//  CountriesData.swift
//  Countries
//
//  Created by ibrahim ahmedoglu on 4.08.2022.
//

import Foundation

struct CountriesData: Codable {
   let data: [Country]
}
struct Country: Codable {
    let code: String
    let wikiDataId: String
    let name: String
    var saved: Bool?
}
