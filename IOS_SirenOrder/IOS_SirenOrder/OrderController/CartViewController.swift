//
//  CartViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/04.
//

import UIKit

class CartViewController: UIViewController { // 2021.08.05 조혜지 장바구니 View

    @IBOutlet weak var tvCart: UITableView!
    @IBOutlet weak var lblStore: UILabel!
    @IBOutlet weak var btnOrder: UIButton!
    @IBOutlet weak var lblCartTotalCount: UILabel!
    @IBOutlet weak var lblCartTotalPrice: UILabel!
    
    var dataItem: NSArray = NSArray()
    var count = NSMutableArray()
    var price = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tvCart.dataSource = self
        self.tvCart.delegate = self
        self.tvCart.separatorStyle = .none
        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
        btnOrder.layer.cornerRadius = 20
        
        goOrder = false
        if storeName == "" {
            lblStore.text = "주문할 매장을 선택해 주세요"
        }else {
            lblStore.text = storeName
        }
        
        let cartSelectModel = CartSelectModel()
        cartSelectModel.delegate = self
        cartSelectModel.downloadItems()
        
        let cartCountModel = CartCountModel()
        cartCountModel.delegate = self
        cartCountModel.downloadItems()

        let cartPriceModel = CartPriceModel()
        cartPriceModel.delegate = self
        cartPriceModel.downloadItems()
    }
    
    @IBAction func btnAllDelete(_ sender: UIBarButtonItem) {
        let cartAllDeleteModel = CartAllDeleteModel()
        let result = cartAllDeleteModel.deleteItems()
        if result {
            let time = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: time) {
                let cartSelectModel = CartSelectModel()
                cartSelectModel.delegate = self
                cartSelectModel.downloadItems()
                self.tvCart.reloadData()
                
                let cartCountModel = CartCountModel()
                cartCountModel.delegate = self
                cartCountModel.downloadItems()
                
                let cartPriceModel = CartPriceModel()
                cartPriceModel.delegate = self
                cartPriceModel.downloadItems()
            }
        }
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        let item: CartModel = dataItem[sender.tag] as! CartModel
        let cartDeleteModel = CartDeleteModel()
        let result = cartDeleteModel.deleteItems(item.cartId!)
        if result {
            let time = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: time) {
                let cartSelectModel = CartSelectModel()
                cartSelectModel.delegate = self
                cartSelectModel.downloadItems()
                self.tvCart.reloadData()
                
                let cartCountModel = CartCountModel()
                cartCountModel.delegate = self
                cartCountModel.downloadItems()
                
                let cartPriceModel = CartPriceModel()
                cartPriceModel.delegate = self
                cartPriceModel.downloadItems()
            }
        }
    }
    
    @IBAction func btnMinus(_ sender: UIButton) {
        let item: CartModel = dataItem[sender.tag] as! CartModel
        let cartCountUpdateModel = CartCountUpdateModel()
        let result = cartCountUpdateModel.uodateItems(item.cartCount!-1, Int(item.cartId!)!)
        if result {
            let time = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: time) {
                let cartSelectModel = CartSelectModel()
                cartSelectModel.delegate = self
                cartSelectModel.downloadItems()
                self.tvCart.reloadData()
                
                let cartCountModel = CartCountModel()
                cartCountModel.delegate = self
                cartCountModel.downloadItems()
                
                let cartPriceModel = CartPriceModel()
                cartPriceModel.delegate = self
                cartPriceModel.downloadItems()
            }
        }
    }
    
    @IBAction func btnPlus(_ sender: UIButton) {
        let item: CartModel = dataItem[sender.tag] as! CartModel
        let cartCountUpdateModel = CartCountUpdateModel()
        let result = cartCountUpdateModel.uodateItems(item.cartCount!+1, Int(item.cartId!)!)
        if result {
            let time = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: time) {
                let cartSelectModel = CartSelectModel()
                cartSelectModel.delegate = self
                cartSelectModel.downloadItems()
                self.tvCart.reloadData()
                
                let cartCountModel = CartCountModel()
                cartCountModel.delegate = self
                cartCountModel.downloadItems()
                
                let cartPriceModel = CartPriceModel()
                cartPriceModel.delegate = self
                cartPriceModel.downloadItems()
            }
        }
    }
    
    @IBAction func btnStore(_ sender: UIButton) {
        self.performSegue(withIdentifier: "sgStoreChoice", sender: self)
    }
    
    @IBAction func btnOrder(_ sender: UIButton) {
        goOrder = true
        if storeName == "" {
            let resultAlert = UIAlertController(title: "주문할 매장을 선택해 주세요!", message: nil, preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.performSegue(withIdentifier: "sgStoreChoice", sender: self)
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }else {
            self.performSegue(withIdentifier: "sgOrder", sender: self)
        }
    }
    
    func DecimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + " 원"
            
            return result
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

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartTableViewCell
        let item: CartModel = dataItem[indexPath.row] as! CartModel
        
        cell.lblDrinkName.text = item.name!
        cell.lblDrinkPrice.text = DecimalWon(value: item.price!)
        cell.lblCartCount.text = String(item.cartCount!)
        cell.lblTotalPrice.text = DecimalWon(value: (item.price! + item.cartPersonalPrice!) * item.cartCount!)
        cell.lblPersonalPrice.text = DecimalWon(value: item.cartPersonalPrice!)
        
        let firstIndex = item.cartPersonal!.index(item.cartPersonal!.startIndex, offsetBy: 0)
        let lastIndex = item.cartPersonal!.index(item.cartPersonal!.startIndex, offsetBy: item.cartPersonal!.count-2)
        cell.lblPersonal.text = String(item.cartPersonal![firstIndex..<lastIndex])
        
        let url = URL(string: "\(item.img!)")
        let data = try? Data(contentsOf: url!)
        cell.ivCart.layer.cornerRadius = cell.ivCart.frame.height / 2
        cell.ivCart.clipsToBounds = true
        cell.ivCart.image = UIImage(data: data!)
        
        cell.btnDelete.tag = indexPath.row
        cell.btnMinus.tag = indexPath.row
        cell.btnPlus.tag = indexPath.row
        
        if item.cartCount == 1 {
            cell.btnMinus.isEnabled = false
        }else {
            cell.btnMinus.isEnabled = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItem.count
    }

}
 
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
}

extension CartViewController : CartSelectModelProtocol {
    func itemDownloaded(items: NSArray) {
        dataItem = items
        self.tvCart.reloadData()
    }
}

extension CartViewController : CartCountModelProtocol {
    func itemDownloaded(items: NSMutableArray) {
        count = items
        let item: PersonalModel = count[0] as! PersonalModel
        lblCartTotalCount.text = "총 \(item.cartCount!) 개"
    }
}

extension CartViewController : CartPriceModelProtocol {
    func priceDownloaded(items: NSMutableArray) {
        price = items
        let item: CartModel = price[0] as! CartModel
        lblCartTotalPrice.text = DecimalWon(value: item.totalPrice!)
    }
}
