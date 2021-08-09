//
//  DrinkDetailViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/03.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

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
    @IBOutlet weak var btnOrder: UIButton!
    
    var receivedCd: String = ""
    var drinkInfo: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //네비게이션 큰글자 삭제
        navigationItem.largeTitleDisplayMode = .never

        let DrinkDetailInfoModel = DrinkDetailInfoModel()
        DrinkDetailInfoModel.delegate = self
        DrinkDetailInfoModel.downloadItems(cd: receivedCd)
        btnOrder.layer.cornerRadius = 20
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    //핫버튼 클릭시
    @IBAction func btnHotAction(_ sender: UIButton) {
        let name = "\(name.text!.replacingOccurrences(of: "아이스", with: "").trimmingCharacters(in: .whitespaces))"
        let DrinkDetailInfoButtonModel = DrinkDetailInfoButtonModel()
        DrinkDetailInfoButtonModel.delegate = self
        DrinkDetailInfoButtonModel.downloadItems(name: name)
        
        
    }
    //아이스 버튼 클릭시
    @IBAction func btnIcedAction(_ sender: UIButton) {
        let name = "아이스 \(name.text!)"
        let DrinkDetailInfoButtonModel = DrinkDetailInfoButtonModel()
        DrinkDetailInfoButtonModel.delegate = self
        DrinkDetailInfoButtonModel.downloadItems(name: name)

    }
    //영양소 버튼 클릭시 바텀시트
    @IBAction func btnNutrition(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NutritionVC") as! NutritionViewController
                
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 650
        
        vc.receivedCd = receivedCd
        present(bottomSheet, animated: true, completion: nil)
        
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgPersonal" {
            let orderPersonalViewController = segue.destination as! OrderPersonalViewController
            orderPersonalViewController.receivedCd = receivedCd
        }
    }
    
    //화면세팅
    func drinkInfoFunc() {
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
        receivedCd = String(item.cd!)
        
    }
    
    //타입별 변화.
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
            btnHot.isEnabled = true
            btnIced.setTitleColor(.blue, for: .normal)
            btnIced.isEnabled = false
            
        case 4:
            lblHotIceOnly.isHidden = true
            btnGroup.isHidden = false
            btnHot.setTitleColor(.red, for: .normal)
            btnHot.isEnabled = false
            btnIced.setTitleColor(.black, for: .normal)
            btnIced.isEnabled = true
            
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

extension DrinkDetailViewController : DrinkDetailInfoButtonModelProtocol{
    func itemDownloadedButton(items: NSArray){
        drinkInfo = items
        drinkInfoFunc()
    }
}

