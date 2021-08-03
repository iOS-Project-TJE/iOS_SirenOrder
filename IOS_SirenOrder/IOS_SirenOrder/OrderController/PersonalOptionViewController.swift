//
//  PersonalOptionViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/02.
//

import UIKit

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
    
    let personalList = ["", "커피", "시럽", "얼음", "휘핑크림", "드리즐", "컵&리드 옵션"]
    var personalOptionName = ""
    var personalOptionPrice = 0
    var personalOptionChangedPrice = 0
    var personalOptionCount = 0
    var myMenuState = true
    var pId = ""
    var cd = ""
    var dataItem: NSArray = NSArray()
    var idItem: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSetting()
        
        self.tvPersonalOption.dataSource = self
        self.tvPersonalOption.delegate = self
    }
    
    func receivedData(_ receivedName: String, _ receivedPrice: Int, _ receivedChangedPrice: Int, _ receivedCount: Int, _ receivedState: Bool, _ receivedCd: String, _ receivedPId: String) {
        personalOptionName = receivedName
        personalOptionPrice = receivedPrice
        personalOptionChangedPrice = receivedChangedPrice
        personalOptionCount = receivedCount
        myMenuState = receivedState
        cd = receivedCd
        pId = receivedPId
    }

    func initSetting() {
        lblPersonalOptionName.text = personalOptionName
        lblPersonalOptionPrice.text = DecimalWon(value: personalOptionChangedPrice)
        lblPersonalOptionCount.text = String(personalOptionCount)

        if cupSize == "Tall" {
            lblPersonalOptionSelected.text = "\(cupSize) (355ml) | \(cupType)"
        }else if cupSize == "Grande" {
            lblPersonalOptionSelected.text = "\(cupSize) (473ml) | \(cupType)"
        }else {
            lblPersonalOptionSelected.text = "\(cupSize) (591ml) | \(cupType)"
        }
        
        
        if personalOptionCount == 1 {
            btnMinus.isEnabled = false
        }
        
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
        personalOptionCount -= 1
        lblPersonalOptionCount.text = String(personalOptionCount)
        personalOptionChangedPrice = personalOptionPrice * personalOptionCount
        lblPersonalOptionPrice.text = DecimalWon(value: personalOptionChangedPrice)
        if personalOptionCount == 1 {
            btnMinus.isEnabled = false
        }
    }
    
    @IBAction func btnPlus(_ sender: UIButton) {
        personalOptionCount += 1
        lblPersonalOptionCount.text = String(personalOptionCount)
        personalOptionChangedPrice = personalOptionPrice * personalOptionCount
        lblPersonalOptionPrice.text = DecimalWon(value: personalOptionChangedPrice)
        btnMinus.isEnabled = true
    }
    
    @IBAction func btnMyMenuSelect(_ sender: UIButton) {
        print("체크해제")
        let myMenuDeleteController = UIAlertController(title: "삭제", message: "나만의 메뉴에서 정말 삭제하시겠습니까?", preferredStyle: .alert)
        let myMenuDeleteConfirmAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
            let myMenuDeleteModel = MyMenuDeleteModel()
            print(self.pId)
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
        let result = myMenuInsertModel.InsertItems(personalContent: "\(iceHot),\(cupSize),\(cupType),\(pContent)", cd: cd, userId: userId)
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            cell.lblPersonalOptionContent.text = ""
            cell.lblPersonalOptionPrice.text = ""
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
