//
//  MyMenuViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/07/30.
//

import UIKit

class MyMenuViewController: UIViewController { // 2021.07.31 조혜지 Order 나만의 메뉴 View

    @IBOutlet weak var tvMyMenu: UITableView!
    @IBOutlet weak var lblStore: UILabel!
    var tag = 0
    
    var dataItem: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myMenuModel = MyMenuModel()
        myMenuModel.delegate = self
        myMenuModel.downloadItems()

        tvMyMenu.dataSource = self
        tvMyMenu.delegate = self
        self.tvMyMenu.separatorStyle = .none
        navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
//        let cell = tvMyMenu.dequeueReusableCell(withIdentifier: "myMenuCell") as! MyMenuTableViewCell
//        let indexPath = self.tvMyMenu.indexPath(for: cell)
//        print(indexPath!.row, "dddd")
//        let item: PersonalModel = dataItem[indexPath!.row] as! PersonalModel
//        let myMenuDeleteModel = MyMenuDeleteModel()
//        let result = myMenuDeleteModel.DeleteItems(personalId: item.personalId!)
//        if result {
//            tvMyMenu.reloadData()
//        }
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
        cell.lblMyMenuPrice.text = "\(DecimalWon(value: item.price!))"
        
        let firstIndex = item.personalContent!.index(item.personalContent!.startIndex, offsetBy: 0)
        let lastIndex = item.personalContent!.index(item.personalContent!.startIndex, offsetBy: item.personalContent!.count-1)
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
        
        if cell.btnDelete.isSelected == true {
            
        }
        
        tag = indexPath.row
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