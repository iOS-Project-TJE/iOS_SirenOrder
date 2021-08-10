//
//  OrderPersonalViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/02.
//

import UIKit

class OrderPersonalViewController: UIViewController { // 2021.08.02 조혜지 주문하기 버튼 클릭 시 View

    var dataItem: NSArray = NSArray()
    var personalItem: NSMutableArray = NSMutableArray()
    var idItem: NSMutableArray = NSMutableArray()
    var cartItem: NSMutableArray = NSMutableArray()
    
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
    
    var receivedCd: String = ""
    var pId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let drinkInfoModel = DrinkInfoModel()
        drinkInfoModel.delegate = self
        drinkInfoModel.downloadItems(cd: receivedCd)
        
        sharePersonalDataInit()
    }
    
    func sharePersonalDataInit() {
        SharePersonalData.drinkCount = 1
        SharePersonalData.btnBool = false
        SharePersonalData.myMenuSelect = false
        SharePersonalData.personalOptionPrice = 0
        SharePersonalData.pPrice = 0
        SharePersonalData.pChangedPrice = 0
        SharePersonalData.size = 0
        pContent = ""
        SharePersonalData.myMenuState = false 
        
        SharePersonal.coffee = ""
        SharePersonal.vSyrup = ""
        SharePersonal.hSyrup = ""
        SharePersonal.cSyrup = ""
        SharePersonal.ice = ""
        SharePersonal.whip = ""
        SharePersonal.caramelDrizzle = ""
        SharePersonal.chocoDrizzle = ""
        SharePersonal.lid = ""
        SharePersonal.coffeeCount = 0
        SharePersonal.coffeeState = 0
        SharePersonal.coffeePrice = 0
        SharePersonal.vSyrupCount = 0
        SharePersonal.hSyrupCount = 0
        SharePersonal.cSyrupCount = 0
        SharePersonal.vSyrupPrice = 0
        SharePersonal.hSyrupPrice = 0
        SharePersonal.cSyrupPrice = 0
        SharePersonal.whipState = 0
        SharePersonal.whipPrice = 0
        SharePersonal.caramelDrizzleState = 0
        SharePersonal.chocoDrizzleState = 0
        SharePersonal.carameldrizzlePrice = 0
        SharePersonal.chocolatedrizzlePrice = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initSetting()
        print("새로 하지???")
    }
    
    func initSetting() {
        btnTallShape.layer.borderWidth = 1.5
        btnGrandeShape.layer.borderWidth = 1.5
        btnVentiShape.layer.borderWidth = 1.5
        btnCartShape.layer.borderWidth = 1
        
        btnTallShape.layer.cornerRadius = 15
        btnGrandeShape.layer.cornerRadius = 15
        btnVentiShape.layer.cornerRadius = 15
        
        if SharePersonalData.size == 0 {
            btnTallShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
            btnGrandeShape.layer.borderColor = UIColor.systemGray5.cgColor
            btnVentiShape.layer.borderColor = UIColor.systemGray5.cgColor
        }else if SharePersonalData.size == 500 {
            btnTallShape.layer.borderColor = UIColor.systemGray5.cgColor
            btnGrandeShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
            btnVentiShape.layer.borderColor = UIColor.systemGray5.cgColor
        }else {
            btnTallShape.layer.borderColor = UIColor.systemGray5.cgColor
            btnGrandeShape.layer.borderColor = UIColor.systemGray5.cgColor
            btnVentiShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        }
        btnCartShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        
        if SharePersonalData.myMenuState == false {
            btnMyMenuNonSelect.isHidden = false
            btnMyMenuSelect.isHidden = true
        }else {
            btnMyMenuNonSelect.isHidden = true
            btnMyMenuSelect.isHidden = false
        }
        
        btnCartShape.layer.cornerRadius = 15
        btnOrderShape.layer.cornerRadius = 15
        
        scShpae.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        if SharePersonalData.personalOptionPrice == 0 {
            lblPersonalPrice.text = ""
        }else {
            lblPersonalPrice.text = DecimalWon(value: SharePersonalData.personalOptionPrice)
        }
        
        pContent = "\(SharePersonal.coffee)\(SharePersonal.vSyrup)\(SharePersonal.hSyrup)\(SharePersonal.cSyrup)\(SharePersonal.ice)\(SharePersonal.whip)\(SharePersonal.caramelDrizzle)\(SharePersonal.chocoDrizzle)\(SharePersonal.lid)"
        if pContent != "" {
            let firstIndex = pContent.index(pContent.startIndex, offsetBy: 0)
            let lastIndex = pContent.index(pContent.startIndex, offsetBy: pContent.count-2)
            lblPersonalContent.text = String(pContent[firstIndex..<lastIndex])
        }else {
            lblPersonalContent.text = ""
        }
        
        lblDrinkPrice.text = DecimalWon(value: SharePersonalData.pChangedPrice+(SharePersonalData.personalOptionPrice*SharePersonalData.drinkCount)+(SharePersonalData.size*SharePersonalData.drinkCount))
        lblDrinkCount.text = String(SharePersonalData.drinkCount)
        btnMinus.isEnabled = SharePersonalData.btnBool
    }
    
    
    @IBAction func btnTall(_ sender: UIButton) {
        if SharePersonalData.size != 0 {
            SharePersonalData.myMenuState = false
            btnMyMenuNonSelect.isHidden = false
            btnMyMenuSelect.isHidden = true
        }
        btnTallShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        btnGrandeShape.layer.borderColor = UIColor.systemGray5.cgColor
        btnVentiShape.layer.borderColor = UIColor.systemGray5.cgColor
        cupSize = "Tall"
        SharePersonalData.size = 0
        lblDrinkPrice.text = DecimalWon(value: SharePersonalData.pChangedPrice+(SharePersonalData.personalOptionPrice*SharePersonalData.drinkCount)+(SharePersonalData.size*SharePersonalData.drinkCount))
    }
    
    @IBAction func btnGrande(_ sender: UIButton) {
        if SharePersonalData.size != 500 {
            SharePersonalData.myMenuState = false
            btnMyMenuNonSelect.isHidden = false
            btnMyMenuSelect.isHidden = true
        }
        btnTallShape.layer.borderColor = UIColor.systemGray5.cgColor
        btnGrandeShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        btnVentiShape.layer.borderColor = UIColor.systemGray5.cgColor
        cupSize = "Grande"
        SharePersonalData.size = 500
        lblDrinkPrice.text = DecimalWon(value: SharePersonalData.pChangedPrice+(SharePersonalData.personalOptionPrice*SharePersonalData.drinkCount)+(SharePersonalData.size*SharePersonalData.drinkCount))
    }
    
    @IBAction func btnVenti(_ sender: UIButton) {
        if SharePersonalData.size != 1000 {
            SharePersonalData.myMenuState = false
            btnMyMenuNonSelect.isHidden = false
            btnMyMenuSelect.isHidden = true
        }
        btnTallShape.layer.borderColor = UIColor.systemGray5.cgColor
        btnGrandeShape.layer.borderColor = UIColor.systemGray5.cgColor
        btnVentiShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        cupSize = "Venti"
        SharePersonalData.size = 1000
        lblDrinkPrice.text = DecimalWon(value: SharePersonalData.pChangedPrice+(SharePersonalData.personalOptionPrice*SharePersonalData.drinkCount)+(SharePersonalData.size*SharePersonalData.drinkCount))
    }
    
    @IBAction func btnCupChoice(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            if cupType != "개인컵" {
                SharePersonalData.myMenuState = false
                btnMyMenuNonSelect.isHidden = false
                btnMyMenuSelect.isHidden = true
            }
            cupType = "개인컵"
        }else if sender.selectedSegmentIndex == 2 {
            if cupType != "일회용컵" {
                SharePersonalData.myMenuState = false
                btnMyMenuNonSelect.isHidden = false
                btnMyMenuSelect.isHidden = true
            }
            cupType = "일회용컵"
        }else {
            if cupType != "매장컵" {
                SharePersonalData.myMenuState = false
                btnMyMenuNonSelect.isHidden = false
                btnMyMenuSelect.isHidden = true
            }
            cupType = "매장컵"
        }
    }
    
    @IBAction func btnMinus(_ sender: UIButton) {
        SharePersonalData.drinkCount -= 1
        lblDrinkCount.text = String(SharePersonalData.drinkCount)
        SharePersonalData.pChangedPrice = SharePersonalData.pPrice * SharePersonalData.drinkCount
        lblDrinkPrice.text = DecimalWon(value: SharePersonalData.pChangedPrice+(SharePersonalData.personalOptionPrice*SharePersonalData.drinkCount)+(SharePersonalData.size*SharePersonalData.drinkCount))
        if SharePersonalData.drinkCount == 1 {
            btnMinus.isEnabled = false
            SharePersonalData.btnBool = false
        }
    }
    
    @IBAction func btnPlus(_ sender: UIButton) {
        SharePersonalData.drinkCount += 1
        lblDrinkCount.text = String(SharePersonalData.drinkCount)
        SharePersonalData.pChangedPrice = SharePersonalData.pPrice * SharePersonalData.drinkCount
        lblDrinkPrice.text = DecimalWon(value: SharePersonalData.pChangedPrice+(SharePersonalData.personalOptionPrice*SharePersonalData.drinkCount)+(SharePersonalData.size*SharePersonalData.drinkCount))
        btnMinus.isEnabled = true
        SharePersonalData.btnBool = true
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
        let myMenuDeleteCancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {ACTION in
            self.btnMyMenuNonSelect.isHidden = true
            self.btnMyMenuSelect.isHidden = false
            SharePersonalData.myMenuState = true
        })
        let myMenuDeleteConfirmAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
            let myMenuDeleteModel = MyMenuDeleteModel()
            let result = myMenuDeleteModel.DeleteItems(personalId: self.pId)
            if result {
                self.btnMyMenuNonSelect.isHidden = false
                self.btnMyMenuSelect.isHidden = true
                SharePersonalData.myMenuState = false
            }
        })

        
        myMenuDeleteController.addAction(myMenuDeleteConfirmAction)
        myMenuDeleteController.addAction(myMenuDeleteCancelAction)
        
        present(myMenuDeleteController, animated: true, completion: nil)
    }
    
    @IBAction func btnMyMenuNonSelect(_ sender: UIButton) {
        btnMyMenuNonSelect.isHidden = true
        btnMyMenuSelect.isHidden = false
        SharePersonalData.myMenuState = true
        
        let myMenuInsertModel = MyMenuInsertModel()
        let result = myMenuInsertModel.InsertItems(personalContent: "\(iceHot), \(cupSize), \(cupType), \(pContent)", cd: receivedCd, userId: userId, personalPrice: SharePersonalData.personalOptionPrice + SharePersonalData.size)
        
//        let personalIdModel = PersonalIdModel()
//        personalIdModel.delegate = self
//        personalIdModel.downloadItems()
                        
        if result{
            let myMenuCheckController = UIAlertController(title: "추가", message: "나만의 메뉴에 추가되었습니다!", preferredStyle: .alert)
            let myMenuCheckAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            myMenuCheckController.addAction(myMenuCheckAction)            
            present(myMenuCheckController, animated: true, completion: nil)
            let personalIdModel = PersonalIdModel()
            personalIdModel.delegate = self
            personalIdModel.downloadItems()
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
        let cartCheckModel = CartCheckModel()
        cartCheckModel.delegate = self
        cartCheckModel.downloadItems(receivedCd, "\(iceHot), \(cupSize), \(cupType), \(pContent)", SharePersonalData.drinkCount)
        
//        if SharePersonal.existCart == false {
            print("설마 여기???")
            let cartInsertModel = CartInsertModel()
            let result = cartInsertModel.InsertItems(cartCount: SharePersonalData.drinkCount, cartPersonal: "\(iceHot), \(cupSize), \(cupType), \(pContent)", cd: receivedCd, userId: userId, cartPersonalPrice: SharePersonalData.personalOptionPrice + SharePersonalData.size)
            
            if result{
                let myMenuCheckController = UIAlertController(title: "추가", message: "장바구니에 추가되었습니다!", preferredStyle: .alert)

                let myMenuCheckAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                let myMenuGoAction = UIAlertAction(title: "보러가기", style: .default, handler: {ACTION in
                    self.performSegue(withIdentifier: "sgCart", sender: self)
                })
                
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
//        }else {
//            let cartForUpdateSelectModel = CartForUpdateSelectModel()
//            cartForUpdateSelectModel.delegate = self
//            cartForUpdateSelectModel.downloadItems(receivedCd, "\(iceHot), \(cupSize), \(cupType), \(pContent)", SharePersonalData.drinkCount)
//
//            let time = DispatchTime.now() + .seconds(1)
//            DispatchQueue.main.asyncAfter(deadline: time) {
//                let cartCountUpdateModel = CartCountUpdateModel()
//                print(SharePersonal.existCartCount,"ㅅㅂㅅㅂㅅㅂㅅㅂㅅ")
//                let result = cartCountUpdateModel.uodateItems(SharePersonal.existCartCount, Int(SharePersonal.existCartId)!)
////                let result = cartCountUpdateModel.uodateItems(45, 1)
//
//                if result {
//                    let myMenuCheckController = UIAlertController(title: "수량 변경", message: "이미 담긴 장바구니에 상품으로, 장바구니 수량을 변경했습니다.", preferredStyle: .alert)
//
//                    let myMenuCheckAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                    let myMenuGoAction = UIAlertAction(title: "보러가기", style: .default, handler: {ACTION in
//                        self.performSegue(withIdentifier: "sgCart", sender: self)
//                    })
//
//                    myMenuCheckController.addAction(myMenuCheckAction)
//                    myMenuCheckController.addAction(myMenuGoAction)
//
//                    self.present(myMenuCheckController, animated: true, completion: nil)
//                }else{
//                    let resultAlert = UIAlertController(title: "실패", message: "에러가 발생되었습니다!", preferredStyle: .alert)
//                    let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
//                        self.navigationController?.popViewController(animated: true)
//                    })
//                    resultAlert.addAction(onAction)
//                    self.present(resultAlert, animated: true, completion: nil)
//                }
//            }
//
//       }
    }
    
    @IBAction func btnOrder(_ sender: UIButton) {
        goOrder = true
        let item: DrinkModel = dataItem[0] as! DrinkModel
        if storeName == "" {
            let resultAlert = UIAlertController(title: "주문할 매장을 선택해 주세요!", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.performSegue(withIdentifier: "sgStoreChoice", sender: self)
                ShareOrder.orderCd = self.receivedCd
                ShareOrder.orderName = item.name!
                ShareOrder.orderCount = SharePersonalData.drinkCount
                ShareOrder.orderPersonal = "\(iceHot), \(cupSize), \(cupType), \(pContent)"
                ShareOrder.orderPersonalPrice = SharePersonalData.personalOptionPrice + SharePersonalData.size
                ShareOrder.orderPrice = item.price!
                ShareOrder.orderImg = item.img!
            })
            resultAlert.addAction(cancelAction)
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true, completion: nil)
        }else {
            self.performSegue(withIdentifier: "sgOrder", sender: self)
            ShareOrder.orderCd = self.receivedCd
            ShareOrder.orderName = item.name!
            ShareOrder.orderCount = SharePersonalData.drinkCount
            ShareOrder.orderPersonal = "\(iceHot), \(cupSize), \(cupType), \(pContent)"
            ShareOrder.orderPersonalPrice = SharePersonalData.personalOptionPrice + SharePersonalData.size
            ShareOrder.orderPrice = item.price!
            ShareOrder.orderImg = item.img!
        }
    }
    
    @IBAction func btnPersonalOption(_ sender: UIButton) {
        self.performSegue(withIdentifier: "sgPersonalOption", sender: self)
    }
    
    func drinkModel() {
        let item: DrinkModel = dataItem[0] as! DrinkModel
                
        SharePersonalData.pPrice = item.price!
        SharePersonalData.pChangedPrice = item.price!
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
            let item: DrinkModel = dataItem[0] as! DrinkModel
            let personalOptionViewController = segue.destination as! PersonalOptionViewController
            personalOptionViewController.receivedData(lblDrinkName.text!, receivedCd, pId, Int(item.price!), item.img!)
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

extension OrderPersonalViewController : CartCheckModelProtocol {
    func priceDownloaded(items: NSMutableArray) {
        personalItem = items
        print(personalItem.count, "personal!!!!")
        let item: CartModel = personalItem[0] as! CartModel
        SharePersonal.existCart = Bool(item.cartCheck!)!
        print(Bool(item.cartCheck!)!)
    }
}

extension OrderPersonalViewController : CartForUpdataeSelectModelProtocol {
    func cartItemDownloaded(items: NSMutableArray) {
        cartItem = items
        
        let item: CartModel = cartItem[0] as! CartModel
        SharePersonal.existCartId = item.cartId!
        SharePersonal.existCartCount = item.cartCount!
    }
}
