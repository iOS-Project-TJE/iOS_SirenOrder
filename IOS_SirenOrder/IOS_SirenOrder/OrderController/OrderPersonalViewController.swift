//
//  OrderPersonalViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/02.
//

import UIKit

class OrderPersonalViewController: UIViewController { // 2021.08.02 조혜지 주문하기 버튼 클릭 시 View

    var dataItem: NSArray = NSArray()
    var idItem: NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var lblDrinkName: UILabel!
    @IBOutlet weak var btnTallShape: UIButton!
    @IBOutlet weak var btnGrandeShape: UIButton!
    @IBOutlet weak var btnVentiShape: UIButton!
    @IBOutlet weak var scShpae: UISegmentedControl!
    @IBOutlet weak var lblPersonalContent: UILabel!
    @IBOutlet weak var lblPersonalPrice: UILabel!
    @IBOutlet weak var lblDrinkPrice: UILabel!
    @IBOutlet weak var lblDrinkCount: UILabel!
    @IBOutlet weak var btnMyMenuSelect: UIButton!
    @IBOutlet weak var btnMyMenuNonSelect: UIButton!
    @IBOutlet weak var btnCartShape: UIButton!
    @IBOutlet weak var btnOrderShape: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    
    var receivedCd = ""
    var pId = ""
    var count = 0
    var price = 0
    var changedPrice = 0
    var myMenuState = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let drinkInfoModel = DrinkInfoModel()
        drinkInfoModel.delegate = self
        drinkInfoModel.downloadItems(cd: receivedCd)
        
        initSetting()
    }
    
    func initSetting() {
        
        btnTallShape.layer.borderWidth = 1.5
        btnGrandeShape.layer.borderWidth = 1.5
        btnVentiShape.layer.borderWidth = 1.5
        btnCartShape.layer.borderWidth = 1
        
        btnTallShape.layer.cornerRadius = 15
        btnGrandeShape.layer.cornerRadius = 15
        btnVentiShape.layer.cornerRadius = 15
        
        btnTallShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        btnGrandeShape.layer.borderColor = UIColor.systemGray5.cgColor
        btnVentiShape.layer.borderColor = UIColor.systemGray5.cgColor
        btnCartShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        
        btnMyMenuNonSelect.isHidden = false
        btnMyMenuSelect.isHidden = true
        
        btnCartShape.layer.cornerRadius = 15
        btnOrderShape.layer.cornerRadius = 15
        
        scShpae.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        lblPersonalContent.text = pContent
        lblPersonalPrice.text = pPrice
        
        if lblDrinkCount.text == "1" {
            btnMinus.isEnabled = false
        }
        count = Int(lblDrinkCount.text!)!
    }
    
    @IBAction func btnTall(_ sender: UIButton) {
        btnTallShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        btnGrandeShape.layer.borderColor = UIColor.systemGray5.cgColor
        btnVentiShape.layer.borderColor = UIColor.systemGray5.cgColor
        cupSize = "Tall"
    }
    
    @IBAction func btnGrande(_ sender: UIButton) {
        btnTallShape.layer.borderColor = UIColor.systemGray5.cgColor
        btnGrandeShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        btnVentiShape.layer.borderColor = UIColor.systemGray5.cgColor
        cupSize = "Grande"
    }
    
    @IBAction func btnVenti(_ sender: UIButton) {
        btnTallShape.layer.borderColor = UIColor.systemGray5.cgColor
        btnGrandeShape.layer.borderColor = UIColor.systemGray5.cgColor
        btnVentiShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        cupSize = "Venti"
    }
    
    @IBAction func btnCupChoice(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            cupType = "개인컵"
        }else if sender.selectedSegmentIndex == 2 {
            cupType = "일회용컵"
        }else {
            cupType = "매장컵"
        }
    }
    
    @IBAction func btnMinus(_ sender: UIButton) {
        count -= 1
        lblDrinkCount.text = String(count)
        changedPrice = price * count
        lblDrinkPrice.text = DecimalWon(value: changedPrice)
        if count == 1 {
            btnMinus.isEnabled = false
        }
    }
    
    @IBAction func btnPlus(_ sender: UIButton) {
        count += 1
        lblDrinkCount.text = String(count)
        changedPrice = price * count
        lblDrinkPrice.text = DecimalWon(value: changedPrice)
        btnMinus.isEnabled = true
    }
    
    func DecimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + " 원"
            
            return result
    }
    
    @IBAction func btnMyMenuSelect(_ sender: UIButton) {
        print("체크해제")
        let myMenuDeleteController = UIAlertController(title: "삭제", message: "나만의 메뉴에서 정말 삭제하시겠습니까?", preferredStyle: .alert)
        let myMenuDeleteConfirmAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
            let myMenuDeleteModel = MyMenuDeleteModel()
            let result = myMenuDeleteModel.DeleteItems(personalId: self.pId)
            if result {
                self.btnMyMenuNonSelect.isHidden = false
                self.btnMyMenuSelect.isHidden = true
                self.myMenuState = false
            }
        })
        let myMenuDeleteCancelAction = UIAlertAction(title: "취소", style: .default, handler: {ACTION in
            self.btnMyMenuNonSelect.isHidden = true
            self.btnMyMenuSelect.isHidden = false
            self.myMenuState = true
        })
        
        myMenuDeleteController.addAction(myMenuDeleteConfirmAction)
        myMenuDeleteController.addAction(myMenuDeleteCancelAction)
        
        present(myMenuDeleteController, animated: true, completion: nil)
    }
    
    @IBAction func btnMyMenuNonSelect(_ sender: UIButton) {
        btnMyMenuNonSelect.isHidden = true
        btnMyMenuSelect.isHidden = false
        myMenuState = true
        
        let myMenuInsertModel = MyMenuInsertModel()
        let result = myMenuInsertModel.InsertItems(personalContent: "\(iceHot),\(cupSize),\(cupType),\(pContent)", cd: receivedCd, userId: userId)
        
        let personalIdModel = PersonalIdModel()
        personalIdModel.delegate = self
        personalIdModel.downloadItems()
                        
        if result{
            let myMenuCheckController = UIAlertController(title: "추가", message: "나만의 메뉴에 추가되었습니다!", preferredStyle: .alert)

            let myMenuCheckAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            let myMenuGoAction = UIAlertAction(title: "보러가기", style: .default, handler: nil)
            
            myMenuCheckController.addAction(myMenuCheckAction)
            myMenuCheckController.addAction(myMenuGoAction)
            
            present(myMenuCheckController, animated: true, completion: nil)
        }else{
            let resultAlert = UIAlertController(title: "실패", message: "에러가 발생되었습니다!", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCart(_ sender: UIButton) {
        let cartInsertModel = CartInsertModel()
        let result = cartInsertModel.InsertItems(cartCount: count, cartPersonal: "\(iceHot),\(cupSize),\(cupType),\(pContent)", cd: receivedCd, userId: userId)
        
        if result{
            let myMenuCheckController = UIAlertController(title: "추가", message: "장바구니에 추가되었습니다!", preferredStyle: .alert)

            let myMenuCheckAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            let myMenuGoAction = UIAlertAction(title: "보러가기", style: .default, handler: nil)
            
            myMenuCheckController.addAction(myMenuCheckAction)
            myMenuCheckController.addAction(myMenuGoAction)
            
            present(myMenuCheckController, animated: true, completion: nil)
        }else{
            let resultAlert = UIAlertController(title: "실패", message: "에러가 발생되었습니다!", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }
    }
    
    func drinkModel() {
        let item: DrinkModel = dataItem[0] as! DrinkModel
                
        price = item.price!
        changedPrice = item.price!
        lblDrinkName.text = item.name!
        lblDrinkPrice.text = "\(DecimalWon(value: item.price!))"

        if item.type == 1 || item.type == 3 {
            iceHot = "Iced"
        }else {
            iceHot = "Hot"
        }
    }
    
    func personalModel() {
        let item: PersonalModel = idItem[0] as! PersonalModel
        pId = item.personalId!
        print("pId", pId)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgPersonalOption" {
            let personalOptionViewController = segue.destination as! PersonalOptionViewController
            personalOptionViewController.receivedData(lblDrinkName.text!, price, changedPrice, count, myMenuState, receivedCd, pId)
        }
    }
    
}

extension OrderPersonalViewController : DrinkInfoModelProtocol {
    func itemDownloaded(items: NSArray) {
        dataItem = items
        drinkModel()
    }
}

extension OrderPersonalViewController : PersonalIdModelProtocol {
    func itemDownloaded(items: NSMutableArray) {
        idItem = items
        personalModel()
    }
}
