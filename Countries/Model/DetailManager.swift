//
//  WeatherManager.swift
//  Clima
//
//  Created by ibrahim ahmedoglu on 12.06.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


protocol DetailManagerDelegate {
    func didUpdateDetail(_ detailManager: DetailManager,details: DetailsModel)
}


struct DetailManager {
    let Detailsurl = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/"
    
    
    var delegate: DetailManagerDelegate?
  
    func fetchDetail(code: String){
        let UrlString = "\(Detailsurl)\(code)?rapidapi-key=a85f7682d4msh8dac1bf49497bd5p1f68fcjsncd0c4e79cc08"
        performRequest(urlString: UrlString)
    }
    
    func performRequest(urlString: String){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data{
                    if let details = self.parseJson(safeData){
                        self.delegate?.didUpdateDetail(self, details: details)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJson(_ detailsData: Foundation.Data) -> DetailsModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DetailsData.self, from: detailsData)
            let details = DetailsModel(code: decodedData.data.code, wikiDataId: decodedData.data.wikiDataId, name: decodedData.data.name, flagImageUri: decodedData.data.flagImageUri)
            return details
            
            
        } catch{
            print(error)
            return nil
        }
        
    }
    
    
}
