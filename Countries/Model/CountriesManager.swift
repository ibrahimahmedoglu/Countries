//
//  WeatherManager.swift
//  Clima
//
//  Created by ibrahim ahmedoglu on 12.06.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol CountriesManagerDelegate {
    func didUpdateCountries(_ countriesManager: CountriesManager,countries: CountriesModel)
}


struct CountriesManager {
    let Countriesurl = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?rapidapi-key=a85f7682d4msh8dac1bf49497bd5p1f68fcjsncd0c4e79cc08"
    
    
    var delegate: CountriesManagerDelegate?
  
    
    func performRequest(){
        
        if let url = URL(string: Countriesurl){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data{
                    if let countries = self.parseJson(safeData){
                        self.delegate?.didUpdateCountries(self, countries: countries)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJson(_ countriesData: Foundation.Data) -> CountriesModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CountriesData.self, from: countriesData)
            let countries = CountriesModel(countries: decodedData.data)
            return countries
            
            
        } catch{
            print(error)
            return nil
        }
        
    }
    
    
}
