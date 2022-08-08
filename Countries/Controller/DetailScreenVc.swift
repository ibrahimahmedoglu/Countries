//
//  DetailScreenVc.swift
//  Countries
//
//  Created by ibrahim ahmedoglu on 6.08.2022.
//

import UIKit


class DetailScreenVc: UIViewController, DetailManagerDelegate, DetailScreenVcdelegate{
    func didUpdateCode(countryCode: String) {
        print("**********************")
        print(countryCode)

        self.Ccode = countryCode
    }
    
    
    
    func didUpdateDetail(_ detailManager: DetailManager, details: DetailsModel) {
        DispatchQueue.main.async {
            self.detailModel = details
            
            self.countryLabel.text = "Country Code: \(self.detailModel.code)"
            
            
        }
    }
    
    var Ccode: String = "US"
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBAction func detailButton(_ sender: Any) {
        var url = "https://www.wikidata.org/wiki/\(detailModel.wikiDataId)"
        UIApplication.shared.openURL(NSURL(string: url)! as URL)
    }
    

    @IBOutlet weak var navigation: UINavigationItem!
    var detailManager = DetailManager()
    var detailModel = DetailsModel(code: "", wikiDataId: "", name: "", flagImageUri: "")
    
    
    var rightImage = UIImage(systemName: "star.fill")
    override func viewDidLoad() {
        super.viewDidLoad()
        detailManager.delegate = self
        let vc = self.navigationController?.viewControllers.first as! ViewController
        vc.detailDelegete = self
        detailManager.fetchDetail(code: vc.cCode)
        
        
        
        
        
        
        var image = UIImage(systemName: "arrow.backward")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(goBack))
        
       
       

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
    


}
