//
//  CountryCell.swift
//  Countries
//
//  Created by ibrahim ahmedoglu on 5.08.2022.
//

import UIKit

protocol FavouriteCellsDelegate {
    func assignFavourites(favourites: Int)
}

class CountryCell: UITableViewCell {
    
    var delegate: FavouriteCellsDelegate?

 
    @IBOutlet weak var label: UILabel!
    var saved: [Bool]!
    
    @IBOutlet weak var savedButtonOutlet: UIButton!
    
    @IBAction func savedButton(_ sender: UIButton) {
        
        
        
        if let tableView = self.superview as? UITableView{
            if let indexPath = tableView.indexPath(for: self){
                if sender.currentImage == UIImage(systemName: "star.fill"){
                    if let image = UIImage(systemName: "star")
                    {
                        
                        savedButtonOutlet.setImage(image, for: .normal)
                        self.delegate?.assignFavourites(favourites: indexPath[1])
                        
                    }
                }else{
                    if let image = UIImage(systemName: "star.fill")
                    {
                        
                        savedButtonOutlet.setImage(image, for: .normal)
                        self.delegate?.assignFavourites(favourites: indexPath[1])
                        
                    }
                }
                
                
            }else{
                print("Indexpath could not be acquired from tableview.")
            }
        }else{
            print("Superview couldn't be cast as tableview")
        }
    }
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 5
        view.layer.cornerRadius = 10
        
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
