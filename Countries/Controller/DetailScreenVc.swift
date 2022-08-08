//
//  DetailScreenVc.swift
//  Countries
//
//  Created by ibrahim ahmedoglu on 6.08.2022.
//

import UIKit
import WebKit
import Kingfisher

class DetailScreenVc: UIViewController, DetailManagerDelegate{
    
    
    func didUpdateDetail(_ detailManager: DetailManager, details: DetailsModel) {
        DispatchQueue.main.async {
            self.detailModel = details
            let url = URL(string: details.flagImageUri)!
            
            self.flagImage.kf.setImage(with: url)
            self.flagImage.reloadInputViews()
            self.countryLabel.text = "Country Code: \(self.detailModel.code)"
            
            
        }
    }
    
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBAction func detailButton(_ sender: Any) {
    }
    

    @IBOutlet weak var navigation: UINavigationItem!
    var detailManager = DetailManager()
    var detailModel = DetailsModel(code: "", wikiDataId: "", name: "", flagImageUri: "")
    
    
    var rightImage = UIImage(systemName: "star.fill")
    override func viewDidLoad() {
        super.viewDidLoad()
        detailManager.delegate = self
        detailManager.fetchDetail(code: "US")
        
        
        
        
        var image = UIImage(systemName: "arrow.backward")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(goBack))
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImage?.withTintColor(.darkGray), style: .plain, target: self, action: #selector(rightPressed) )
        

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func goBack() {
        _ = navigationController?.popViewController(animated: true)
            }
    
    @objc func rightPressed() {
        if rightImage == UIImage(systemName: "star.fill"){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(rightPressed))
            rightImage = UIImage(systemName: "star")
            }
        else{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(rightPressed))
            rightImage = UIImage(systemName: "star.fill")
        }
    }


}
