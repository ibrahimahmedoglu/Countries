//
//  ViewController.swift
//  Countries
//
//  Created by ibrahim ahmedoglu on 4.08.2022.
//

import UIKit

protocol SavedScreenVcdelegate {
    func didUpdateCountries(countries: [Country])
}
protocol DetailScreenVcdelegate {
    func didUpdateCode(countryCode: String)
}

class ViewController: UIViewController, CountriesManagerDelegate, FavouriteCellsDelegate
{
    var delegate: SavedScreenVcdelegate?
    
    var detailDelegete: DetailScreenVcdelegate?
    

    @IBOutlet weak var tableView: UITableView!
    
    
    var countriesManager = CountriesManager()
    var countriesList: [Country] = []
    var cCode: String = ""
  
     
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        countriesManager.delegate = self
        

        
        
        
        countriesManager.performRequest()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
       
        // Do any additional setup after loading the view.
    }
    
    func didUpdateCountries(_ countriesManager: CountriesManager, countries: CountriesModel)  {
        DispatchQueue.main.async {
            self.countriesList = countries.countries
            self.tableView.reloadData()
        }
    }
    func assignFavourites(favourites: Int){
        
        if countriesList[favourites].saved == true {
            countriesList[favourites].saved = false
            print(countriesList[favourites].wikiDataId)
            self.delegate?.didUpdateCountries(countries: countriesList)
            
        } else {
            countriesList[favourites].saved = true
            
            self.delegate?.didUpdateCountries(countries: countriesList)
        }
        
    }
    func updateTabelView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    



}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CountryCell
        cell.delegate = self
        
        cell.label?.text = countriesList[indexPath.row].name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.cCode = countriesList[indexPath.row].code
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    
}



