//
//  MyMenuViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/07/30.
//

import UIKit

class MyMenuViewController: UIViewController { // 2021.07.31 조혜지 Order 나만의 메뉴 View
                                               // 2021.08.04 조혜지 Order 나만의 메뉴 삭제, 담기, 주문하기 클릭 이벤트

    @IBOutlet weak var tvMyMenu: UITableView!
    @IBOutlet weak var lblStore: UILabel!
    @IBOutlet weak var lblCartCount: UILabel!
    
    var tag: Int = 0
    var data: NSMutableArray = NSMutableArray()
    var dataItem: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let myMenuModel = MyMenuModel()
        myMenuModel.delegate = self
        myMenuModel.downloadItems()
        
        let cartCountModel = CartCountModel()
        cartCountModel.delegate = self
        cartCountModel.downloadItems()

        tvMyMenu.dataSource = self
        tvMyMenu.delegate = self
        self.tvMyMenu.separatorStyle = .none
        navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        tvMyMenu.bounces = true
        tvMyMenu.alwaysBounceVertical = true
        
        if storeName == "" {
            lblStore.text = "주문할 매장을 선택해 주세요"
        }else {
            lblStore.text = storeName
        }
    }
    
    @IBAction func btnMyMenuDelete(_ sender: UIButton) {
        let item: PersonalModel = dataItem[sender.tag] as! PersonalModel
        let myMenuDeleteModel = MyMenuDeleteModel()
        let result = myMenuDeleteModel.DeleteItems(personalId: item.personalId!)
        if result {
            let time = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: time) {
                let myMenuModel = MyMenuModel()
                myMenuModel.delegate = self
                myMenuModel.downloadItems()
                self.tvMyMenu.reloadData()
            }
        }
    }
    
    @IBAction func btnCart(_ sender: UIButton) {
        let item: PersonalModel = dataItem[sender.tag] as! PersonalModel
        let cartInsertModel = CartInsertModel()
        let result = cartInsertModel.InsertItems(cartCount: 1, cartPersonal: item.personalContent!, cd: item.cd!, userId: userId, cartPersonalPrice: item.personalPrice!)
        
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
    }
    
    @IBAction func btnOrder(_ sender: UIButton) {
        let item: PersonalModel = dataItem[sender.tag] as! PersonalModel
        goOrder = true
        if storeName == "" {
            let resultAlert = UIAlertController(title: "주문할 매장을 선택해 주세요!", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.performSegue(withIdentifier: "sgStoreChoice", sender: self)
                ShareOrder.orderCd = item.cd!
                ShareOrder.orderName = item.name!
                ShareOrder.orderCount = 1
                ShareOrder.orderPersonal = item.personalContent!
                ShareOrder.orderPersonalPrice = item.personalPrice!
                ShareOrder.orderPrice = item.price!
                ShareOrder.orderImg = item.img!
            })
            resultAlert.addAction(cancelAction)
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true, completion: nil)
        }else {
            self.performSegue(withIdentifier: "sgOrder", sender: self)
            ShareOrder.orderCd = item.cd!
            ShareOrder.orderName = item.name!
            ShareOrder.orderCount = 1
            ShareOrder.orderPersonal = item.personalContent!
            ShareOrder.orderPersonalPrice = item.personalPrice!
            ShareOrder.orderPrice = item.price!
            ShareOrder.orderImg = item.img!
        }
    }
    
    @IBAction func btnStore(_ sender: UIButton) {
        self.performSegue(withIdentifier: "sgStoreChoice", sender: self)
    }
    
    @IBAction func btnGoCart(_ sender: UIButton) {
        self.performSegue(withIdentifier: "sgCart", sender: self)
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

extension MyMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMenuCell") as! MyMenuTableViewCell
        let item: PersonalModel = dataItem[indexPath.row] as! PersonalModel
        cell.lblMyMenuName.text = "\(item.name!)"
        cell.lblMyMenuPrice.text = "\(DecimalWon(value: item.price!+item.personalPrice!))"
        
        let firstIndex = item.personalContent!.index(item.personalContent!.startIndex, offsetBy: 0)
        let lastIndex = item.personalContent!.index(item.personalContent!.startIndex, offsetBy: item.personalContent!.count-2)
        cell.lblMyMenuPersonal.text = String(item.personalContent![firstIndex..<lastIndex])
        
        let url = URL(string: "\(item.img!)")
        let data = try? Data(contentsOf: url!)
        cell.ivMyMenu.layer.cornerRadius = cell.ivMyMenu.frame.height / 2
        cell.ivMyMenu.clipsToBounds = true
        cell.ivMyMenu.image = UIImage(data: data!)
        
        cell.btnCartShape.layer.borderWidth = 1
        cell.btnCartShape.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        cell.btnCartShape.layer.cornerRadius = 15
        cell.btnOrderShape.layer.cornerRadius = 15
        
        cell.btnDelete.tag = indexPath.row
        cell.btnCartShape.tag = indexPath.row
        cell.btnOrderShape.tag = indexPath.row
        
        return cell
    }
    
    func DecimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + " 원"
            
            return result
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItem.count
    }

}
 
extension MyMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 217
    }
}

extension MyMenuViewController: MyMenuModelProtocol {
    func itemDownloaded(items: NSArray) {
        dataItem = items
        self.tvMyMenu.reloadData()
    }
}

extension MyMenuViewController : CartCountModelProtocol {
    func itemDownloaded(items: NSMutableArray) {
        data = items
        
        let item: PersonalModel = data[0] as! PersonalModel
        lblCartCount.text = String(item.cartCount!)
    }
}
