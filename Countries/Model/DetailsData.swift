//
//  DetailsData.swift
//  Countries
//
//  Created by ibrahim ahmedoglu on 7.08.2022.
//

import Foundation

struct DetailsData: Codable {
   let data: Detail
}
struct Detail: Codable {
    let code: String
    let wikiDataId: String
    let name: String
    let flagImageUri: String
}
