//
//  CategoryDetailViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/01.
//

import UIKit

class CategoryDetailViewController: UIViewController { // 2021.08.01 조혜지 Order Category 선택 후 카테고리 별 메뉴 View

    @IBOutlet weak var tvCategoryDetail: UITableView!
    @IBOutlet weak var lblStore: UILabel!
    @IBOutlet weak var lblCartCount: UILabel!
    
    var dataItem: NSArray = NSArray()
    var data: NSMutableArray = NSMutableArray()
    var indexPath = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tvCategoryDetail.dataSource = self
        self.tvCategoryDetail.delegate = self
        self.tvCategoryDetail.separatorStyle = .none
        self.navigationItem.title = categoryList[indexPath]
        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        goOrder = false
        
        let categoryDetailModel = CategoryDetailModel()
        categoryDetailModel.delegate = self
        categoryDetailModel.downloadItems()
        
        let cartCountModel = CartCountModel()
        cartCountModel.delegate = self
        cartCountModel.downloadItems()
        
        if storeName == "" {
            lblStore.text = "주문할 매장을 선택해 주세요"
        }else {
            lblStore.text = storeName
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDrinkDetail" {
            let cell = sender as! CategoryDetailTableViewCell
            let indexPath = self.tvCategoryDetail.indexPath(for: cell)
            
            let item: DrinkModel = dataItem[indexPath!.row] as! DrinkModel
            
            let drinkDetailViewController = segue.destination as! DrinkDetailViewController
            drinkDetailViewController.receivedCd = item.cd!
        }
    }
    

}

extension CategoryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryDetailCell") as! CategoryDetailTableViewCell
        let item: DrinkModel = dataItem[indexPath.row] as! DrinkModel
        
        cell.lblCategoryDetailName.text = item.name!
        cell.lblCategoryDetailPrice.text = DecimalWon(value: item.price!)
        
        let url = URL(string: "\(item.img!)")
        let data = try? Data(contentsOf: url!)
        cell.ivCategoryDetail.layer.cornerRadius = cell.ivCategoryDetail.frame.height / 2
        cell.ivCategoryDetail.clipsToBounds = true
        cell.ivCategoryDetail.image = UIImage(data: data!)
        
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
 
extension CategoryDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension CategoryDetailViewController : CategoryDetailModelProtocol {
    func itemDownloaded(items: NSArray) {
        dataItem = items
        self.tvCategoryDetail.reloadData()
    }
}

extension CategoryDetailViewController : CartCountModelProtocol {
    func itemDownloaded(items: NSMutableArray) {
        data = items
        
        let item: PersonalModel = data[0] as! PersonalModel
        lblCartCount.text = String(item.cartCount!)
    }
}
