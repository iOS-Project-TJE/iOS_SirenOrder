//
//  DrinkDetailViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/03.
//

import UIKit

class DrinkDetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var btnGroup: UIStackView!
    @IBOutlet weak var btnHot: UIButton!
    @IBOutlet weak var btnIced: UIButton!
    @IBOutlet weak var lblHotIceOnly: UILabel!
    @IBOutlet weak var allergie: UILabel!
    
    var receivedCd: String = ""
    var drinkInfo: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let DrinkDetailInfoModel = DrinkDetailInfoModel()
        DrinkDetailInfoModel.delegate = self
        DrinkDetailInfoModel.downloadItems(cd: receivedCd)
        
        
        // Do any additional setup after loading the view.
    }
    func drinkInfoFunc(){
        let item: DrinkModel = drinkInfo[0] as! DrinkModel
        
        let url = URL(string:"\(item.img!)")
        let data = try? Data(contentsOf: url!)
        image.image = UIImage(data: data!)
        
        name.text = item.name!
        content.text = item.content!
        price.text = "\(DecimalWon(value: item.price!))"
        typeChange(type: item.type!)
        if item.allergie! == "null" {
            allergie.text = ""
        }else{
            allergie.text = item.allergie!
       }
        
    }
    @IBAction func btnHotAction(_ sender: UIButton) {
        
        
    }
    @IBAction func btnIcedAction(_ sender: UIButton) {
        
        
    }
    
    @IBAction func btnNutrition(_ sender: UIButton) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgPersonal" {
            let orderPersonalViewController = segue.destination as! OrderPersonalViewController
            orderPersonalViewController.receivedCd = receivedCd
        }
    }
    
    func typeChange(type: Int) {
        switch type {
        case 1:
            lblHotIceOnly.isHidden = false
            btnGroup.isHidden = true
            lblHotIceOnly.text = "ICED ONLY"
            lblHotIceOnly.textColor = UIColor.blue
            
        case 2:
            lblHotIceOnly.isHidden = false
            btnGroup.isHidden = true
            lblHotIceOnly.text = "HOT ONLY"
            lblHotIceOnly.textColor = UIColor.red
            
        case 3:
            lblHotIceOnly.isHidden = true
            btnGroup.isHidden = false
            btnHot.setTitleColor(.black, for: .normal)
            btnIced.setTitleColor(.blue, for: .normal)
            
        case 4:
            lblHotIceOnly.isHidden = true
            btnGroup.isHidden = false
            btnHot.setTitleColor(.red, for: .normal)
            btnIced.setTitleColor(.black, for: .normal)
            
        default:
            print("fail")
        }
        
    }
    
    //금액 메소드
    func DecimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + " 원"
            
            return result
    }
    

}
extension DrinkDetailViewController : DrinkDetailInfoModelProtocol{
    func itemDownloaded(items: NSArray){
        drinkInfo = items
        drinkInfoFunc()
    }
}
