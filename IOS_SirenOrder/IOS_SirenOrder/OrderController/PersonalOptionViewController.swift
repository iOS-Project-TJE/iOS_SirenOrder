//
//  PersonalOptionViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/02.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

let personalList = ["", "커피", "시럽", "얼음", "휘핑크림", "드리즐", "컵&리드 옵션"]
let DidDismissPersonalOptionViewController: Notification.Name = Notification.Name("DidDismissPersonalOptionViewController")

class PersonalOptionViewController: UIViewController { // 2021.08.02 조혜지 퍼스널 옵션 버튼 클릭 시 View

    @IBOutlet weak var tvPersonalOption: UITableView!
    @IBOutlet weak var lblPersonalOptionName: UILabel!
    @IBOutlet weak var lblPersonalOptionPrice: UILabel!
    @IBOutlet weak var lblPersonalOptionCount: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnMyMenuSelect: UIButton!
    @IBOutlet weak var btnMyMenuNonSelect: UIButton!
    @IBOutlet weak var btnCartShape: UIButton!
    @IBOutlet weak var btnOrderShape: UIButton!
    @IBOutlet weak var lblPersonalOptionSelected: UILabel!
    
    var personalOptionName = ""
    var myMenuState = true
    var pId = ""
    var cd = ""
    var price = 0
    var img = ""
    var dataItem: NSArray = NSArray()
    var idItem: NSMutableArray = NSMutableArray()
    var personalTotalPrice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSetting()
        
        self.tvPersonalOption.dataSource = self
        self.tvPersonalOption.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didDismissPersonalOptionNotification(_:)), name: DidDismissPersonalOptionViewController, object: nil)
    }
    
    @objc func didDismissPersonalOptionNotification(_ noti: Notification) {
        OperationQueue.main.addOperation {
            self.tvPersonalOption.reloadData()
            self.personalTotalPrice = SharePersonal.coffeePrice + SharePersonal.vSyrupPrice + SharePersonal.hSyrupPrice + SharePersonal.cSyrupPrice + SharePersonal.whipPrice + SharePersonal.carameldrizzlePrice + SharePersonal.chocolatedrizzlePrice
            SharePersonalData.personalOptionPrice = self.personalTotalPrice
            self.lblPersonalOptionPrice.text = self.DecimalWon(value: SharePersonalData.pChangedPrice+(self.personalTotalPrice*SharePersonalData.drinkCount)+(SharePersonalData.size*SharePersonalData.drinkCount))
        }
    }
    
    func receivedData(_ receivedName: String, _ receivedState: Bool, _ receivedCd: String, _ receivedPId: String, _ receivedPrice: Int, _ receivedImg: String) {
        personalOptionName = receivedName
        myMenuState = receivedState
        cd = receivedCd
        pId = receivedPId
        price = receivedPrice
        img = receivedImg
    }

    func initSetting() {
        lblPersonalOptionName.text = personalOptionName
        lblPersonalOptionPrice.text = DecimalWon(value: SharePersonalData.pChangedPrice+(SharePersonalData.personalOptionPrice*SharePersonalData.drinkCount)+(SharePersonalData.size*SharePersonalData.drinkCount))
        lblPersonalOptionCount.text = String(SharePersonalData.drinkCount+(personalTotalPrice*SharePersonalData.drinkCount))
        
        if cupSize == "Tall" {
            lblPersonalOptionSelected.text = "\(cupSize) (355ml) | \(cupType)"
        }else if cupSize == "Grande" {
            lblPersonalOptionSelected.text = "\(cupSize) (473ml) | \(cupType)"
        }else {
            lblPersonalOptionSelected.text = "\(cupSize) (591ml) | \(cupType)"
        }
        
        btnMinus.isEnabled = SharePersonalData.btnBool
        
        btnCartShape.layer.borderWidth = 1
        btnCartShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        
        btnCartShape.layer.cornerRadius = 15
        btnOrderShape.layer.cornerRadius = 15
        
        if myMenuState == true {
            btnMyMenuNonSelect.isHidden = true
            btnMyMenuSelect.isHidden = false
        }else {
            btnMyMenuNonSelect.isHidden = false
            btnMyMenuSelect.isHidden = true
        }
    }
    
    func DecimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + " 원"
            
            return result
    }
    
    @IBAction func btnMinus(_ sender: UIButton) {
        SharePersonalData.drinkCount -= 1
        lblPersonalOptionCount.text = String(SharePersonalData.drinkCount)
        SharePersonalData.pChangedPrice = SharePersonalData.pPrice * SharePersonalData.drinkCount
        lblPersonalOptionPrice.text = DecimalWon(value: SharePersonalData.pChangedPrice+(SharePersonalData.personalOptionPrice*SharePersonalData.drinkCount)+(SharePersonalData.size*SharePersonalData.drinkCount))
        if SharePersonalData.drinkCount == 1 {
            btnMinus.isEnabled = false
            SharePersonalData.btnBool = false
        }
    }
    
    @IBAction func btnPlus(_ sender: UIButton) {
        SharePersonalData.drinkCount += 1
        lblPersonalOptionCount.text = String(SharePersonalData.drinkCount)
        SharePersonalData.pChangedPrice = SharePersonalData.pPrice * SharePersonalData.drinkCount
        lblPersonalOptionPrice.text = DecimalWon(value: SharePersonalData.pChangedPrice+(SharePersonalData.personalOptionPrice*SharePersonalData.drinkCount)+(SharePersonalData.size*SharePersonalData.drinkCount))
        btnMinus.isEnabled = true
        SharePersonalData.btnBool = true
    }
    
    @IBAction func btnMyMenuSelect(_ sender: UIButton) {
        let myMenuDeleteController = UIAlertController(title: "삭제", message: "나만의 메뉴에서 정말 삭제하시겠습니까?", preferredStyle: .alert)
        let myMenuDeleteCancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {ACTION in
            self.btnMyMenuNonSelect.isHidden = true
            self.btnMyMenuSelect.isHidden = false
            self.myMenuState = true
        })
        let myMenuDeleteConfirmAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
            let myMenuDeleteModel = MyMenuDeleteModel()
            let result = myMenuDeleteModel.DeleteItems(personalId: self.pId)
            if result {
                self.btnMyMenuNonSelect.isHidden = false
                self.btnMyMenuSelect.isHidden = true
                self.myMenuState = false
            }
        })
        myMenuDeleteController.addAction(myMenuDeleteCancelAction)
        myMenuDeleteController.addAction(myMenuDeleteConfirmAction)
        
        present(myMenuDeleteController, animated: true, completion: nil)
    }
    
    @IBAction func btnMyMenuNonSelect(_ sender: UIButton) {
        btnMyMenuNonSelect.isHidden = true
        btnMyMenuSelect.isHidden = false
        myMenuState = true
        
        pContent = "\(SharePersonal.coffee)\(SharePersonal.vSyrup)\(SharePersonal.hSyrup)\(SharePersonal.cSyrup)\(SharePersonal.ice)\(SharePersonal.whip)\(SharePersonal.caramelDrizzle)\(SharePersonal.chocoDrizzle)\(SharePersonal.lid)"
        
        let myMenuInsertModel = MyMenuInsertModel()
        let result = myMenuInsertModel.InsertItems(personalContent: "\(iceHot), \(cupSize), \(cupType), \(pContent)", cd: cd, userId: userId, personalPrice: SharePersonalData.personalOptionPrice + SharePersonalData.size)
        
        let personalIdModel = PersonalIdModel()
        personalIdModel.delegate = self
        personalIdModel.downloadItems()
                        
        if result{
            let myMenuCheckController = UIAlertController(title: "추가", message: "나만의 메뉴에 추가되었습니다!", preferredStyle: .alert)
            let myMenuCheckAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            myMenuCheckController.addAction(myMenuCheckAction)
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
    }
    
    @IBAction func btnOrder(_ sender: UIButton) {
        goOrder = true
        if storeName == "" {
            let resultAlert = UIAlertController(title: "주문할 매장을 선택해 주세요!", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.performSegue(withIdentifier: "sgStoreChoice", sender: self)
                ShareOrder.orderCd = self.cd
                ShareOrder.orderName = self.personalOptionName
                ShareOrder.orderCount = SharePersonalData.drinkCount
                ShareOrder.orderPersonal = "\(iceHot), \(cupSize), \(cupType), \(SharePersonal.coffee)\(SharePersonal.vSyrup)\(SharePersonal.hSyrup)\(SharePersonal.cSyrup)\(SharePersonal.ice)\(SharePersonal.whip)\(SharePersonal.caramelDrizzle)\(SharePersonal.chocoDrizzle)\(SharePersonal.lid)"
                ShareOrder.orderPersonalPrice = SharePersonalData.personalOptionPrice
                ShareOrder.orderPrice = self.price
                ShareOrder.orderImg = self.img
            })
            resultAlert.addAction(cancelAction)
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true, completion: nil)
        }else {
            self.performSegue(withIdentifier: "sgOrder", sender: self)
            ShareOrder.orderCd = self.cd
            ShareOrder.orderName = self.personalOptionName
            ShareOrder.orderCount = SharePersonalData.drinkCount
            ShareOrder.orderPersonal = "\(iceHot), \(cupSize), \(cupType), \(SharePersonal.coffee)\(SharePersonal.vSyrup)\(SharePersonal.hSyrup)\(SharePersonal.cSyrup)\(SharePersonal.ice)\(SharePersonal.whip)\(SharePersonal.caramelDrizzle)\(SharePersonal.chocoDrizzle)\(SharePersonal.lid)"
            ShareOrder.orderPersonalPrice = SharePersonalData.personalOptionPrice
            ShareOrder.orderPrice = self.price
            ShareOrder.orderImg = self.img
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgPersonalDetail" {
            let personalOptionDetailViewController = storyboard?.instantiateViewController(withIdentifier: "PersonalOptionDetailViewController") as! PersonalOptionDetailViewController
            
            let cellContent = sender as! PersonalOptionContentTableViewCell
            let indexPath = self.tvPersonalOption.indexPath(for: cellContent)
                        
            personalOptionDetailViewController.receivedIndexPath = indexPath!.row
            
            let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: personalOptionDetailViewController)
            bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 570
            present(bottomSheet, animated: true, completion: nil)
        }
    }
    

}

extension PersonalOptionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "personalTitleCell") as! PersonalOptionTitleTableViewCell
            cell.selectionStyle = .none
            cell.btnRefresh.isHidden = true
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "personalContentCell") as! PersonalOptionContentTableViewCell
            cell.selectionStyle = .none
            cell.lblPersonalOptionList.text = personalList[indexPath.row]
            if indexPath.row == 1 {
                var coffeePrice = 0
                cell.lblPersonalOptionContent.text = SharePersonal.coffee.components(separatedBy: ",")[0]
                if SharePersonal.coffeeCount == 0 {
                    cell.lblPersonalOptionPrice.text = ""
                }else {
                    if SharePersonal.coffeeState == 0 {
                        coffeePrice = (600 * SharePersonal.coffeeCount)
                    }else {
                        coffeePrice = (600 * SharePersonal.coffeeCount) + 300
                    }
                    cell.lblPersonalOptionPrice.text = "\(coffeePrice) 원"
                }
            }else if indexPath.row == 2 {
                cell.lblPersonalOptionContent.text = "\(SharePersonal.vSyrup.components(separatedBy: ",")[0]) \(SharePersonal.hSyrup.components(separatedBy: ",")[0]) \(SharePersonal.cSyrup.components(separatedBy: ",")[0])"
                if SharePersonal.cSyrupCount == 0 && SharePersonal.hSyrupCount == 0 && SharePersonal.vSyrupCount == 0 {
                    cell.lblPersonalOptionPrice.text = ""
                }else {
                    var syrupPrice = 0
                    if SharePersonal.cSyrupCount != 0 {
                        syrupPrice += 600
                    }
                    if SharePersonal.hSyrupCount != 0 {
                        syrupPrice += 600
                    }
                    if SharePersonal.vSyrupCount != 0 {
                        syrupPrice += 600
                    }
                    cell.lblPersonalOptionPrice.text = "\(syrupPrice) 원"
                }
            }else if indexPath.row == 3 {
                cell.lblPersonalOptionContent.text = SharePersonal.ice.components(separatedBy: ",")[0]
                cell.lblPersonalOptionPrice.text = ""
            }else if indexPath.row == 4 {
                var whipPrice = 0
                cell.lblPersonalOptionContent.text = SharePersonal.whip.components(separatedBy: ",")[0]
                if SharePersonal.whipState != 0 {
                    whipPrice = 600
                    cell.lblPersonalOptionPrice.text = "\(whipPrice) 원"
                }else {
                    cell.lblPersonalOptionPrice.text = ""
                }
            }else if indexPath.row == 5 {
                cell.lblPersonalOptionContent.text = "\(SharePersonal.caramelDrizzle.components(separatedBy: ",")[0]) \(SharePersonal.chocoDrizzle.components(separatedBy: ",")[0])"
                if SharePersonal.caramelDrizzleState == 0 && SharePersonal.chocoDrizzleState == 0 {
                    cell.lblPersonalOptionPrice.text = ""
                }else {
                    var drizzlePrice = 0
                    if SharePersonal.caramelDrizzleState != 0 {
                        drizzlePrice += 600
                    }
                    if SharePersonal.chocoDrizzleState != 0 {
                        drizzlePrice += 600
                    }
                    cell.lblPersonalOptionPrice.text = "\(drizzlePrice) 원"
                }
            }else if indexPath.row == 6 {
                cell.lblPersonalOptionContent.text = SharePersonal.lid.components(separatedBy: ",")[0]
                cell.lblPersonalOptionPrice.text = ""
            }
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalList.count
    }
    
    func personalModel() {
        let item: PersonalModel = idItem[0] as! PersonalModel
        pId = item.personalId!
        print("pId", pId)
    }

}
 
extension PersonalOptionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }else {
            return 80
        }
    }
}

extension PersonalOptionViewController : PersonalIdModelProtocol {
    func itemDownloaded(items: NSMutableArray) {
        idItem = items
        personalModel()
    }

}
