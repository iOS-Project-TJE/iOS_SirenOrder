//
//  NutritionViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/07.
//

import UIKit

class NutritionViewController: UIViewController {

    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var kcal: UILabel!
    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var fat: UILabel!
    @IBOutlet weak var sodium: UILabel!
    @IBOutlet weak var sugars: UILabel!
    @IBOutlet weak var caffeine: UILabel!
    @IBOutlet weak var cholesterol: UILabel!
    @IBOutlet weak var carbo: UILabel!
    
    var receivedCd: String = ""
    var NutritionInfo: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let DrinkDetailInfoNutritionModel = DrinkDetailInfoNutritionModel()
        DrinkDetailInfoNutritionModel.delegate = self
        DrinkDetailInfoNutritionModel.downloadItems(cd: receivedCd)
    }
    
    func NutritionInfoFunc(){
        let item: DrinkModel = NutritionInfo[0] as! DrinkModel
        
        volume.text = item.volume!
        kcal.text = item.kcal!
        protein.text = item.protein!
        fat.text = item.fat!
        sodium.text = item.sodium!
        sugars.text = item.sugars!
        caffeine.text = item.caffeine!
        cholesterol.text = item.cholesterol!
        carbo.text = item.carbo!
        
    }
    
}

extension NutritionViewController : DrinkDetailInfoNutritionModelProtocol{
    func itemDownloaded(items: NSArray) {
        NutritionInfo=items
        NutritionInfoFunc()
    }
}
