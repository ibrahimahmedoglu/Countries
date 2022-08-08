//
//  SavedScreenVC.swift
//  Countries
//
//  Created by ibrahim ahmedoglu on 5.08.2022.
//

import UIKit

class SavedScreenVC: UIViewController, FavouriteCellsDelegate, SavedScreenVcdelegate {
    func didUpdateCountries(countries: [Country]) {
        DispatchQueue.main.async {
            
            self.countriesList = self.removeNonSaved(countries: countries)
            self.tableView.reloadData()
        }
    }
    
    func assignFavourites(favourites: Int) {
        if countriesList[favourites].saved == true {
            countriesList[favourites].saved = false
            let navVC = self.tabBarController?.viewControllers![0] as! UINavigationController
            let cartTableViewController = navVC.topViewController as!ViewController
            cartTableViewController.tableView.reloadData()
            countriesList.remove(at: favourites)
            tableView.reloadData()
            
        } else{
            countriesList[favourites].saved = true
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    var countriesList: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navVC = self.tabBarController?.viewControllers![0] as! UINavigationController
        let cartTableViewController = navVC.topViewController as!ViewController
        cartTableViewController.delegate = self
        DispatchQueue.main.async {
            self.countriesList = self.removeNonSaved(countries: cartTableViewController.countriesList)
            self.tableView.reloadData()
            
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        // Do any additional setup after loading the view.
    }
    
    
    func removeNonSaved(countries: [Country]) ->[Country]{
        var temp:[Country] = []
        for (index, country) in countries.enumerated() {
            if country.saved == true {
                temp.append(country)
                print(index)
            }
        }
        return temp
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SavedScreenVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CountryCell
        cell.delegate = self
        
        cell.label?.text = countriesList[indexPath.row].name
        cell.savedButtonOutlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
}
