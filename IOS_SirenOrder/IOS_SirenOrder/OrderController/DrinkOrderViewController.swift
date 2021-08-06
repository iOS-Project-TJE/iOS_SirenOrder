//
//  DrinkOrderViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/04.
//

import UIKit

class DrinkOrderViewController: UIViewController { // 2021.08.05 조혜지 결제하기 View

    @IBOutlet weak var btnCard: UIButton!
    @IBOutlet weak var btnAccount: UIButton!
    @IBOutlet weak var btnGift: UIButton!
    @IBOutlet weak var ivCard: UIImageView!
    @IBOutlet weak var ivAccount: UIImageView!
    @IBOutlet weak var ivGift: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var btnOrder: UIButton!
    @IBOutlet weak var lblTotalCount: UILabel!
    @IBOutlet weak var tvOrder: UITableView!
    
    var dataItem: NSArray = NSArray()
    var count: NSMutableArray = NSMutableArray()
    var price: NSMutableArray = NSMutableArray()
    var giftPrice: NSMutableArray = NSMutableArray()
    var pay: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        btnCard.layer.borderWidth = 1.5
        btnAccount.layer.borderWidth = 1.5
        btnGift.layer.borderWidth = 1.5
        
        btnCard.layer.cornerRadius = 15
        btnAccount.layer.cornerRadius = 15
        btnGift.layer.cornerRadius = 15
        btnOrder.layer.cornerRadius = 20
        
        btnGift.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        btnAccount.layer.borderColor = UIColor.systemGray5.cgColor
        btnCard.layer.borderColor = UIColor.systemGray5.cgColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let cartSelectModel = CartSelectModel()
        cartSelectModel.delegate = self
        cartSelectModel.downloadItems()
        
        let giftPriceModel = GiftPriceModel()
        giftPriceModel.delegate = self
        giftPriceModel.downloadItems()
        
        self.tvOrder.dataSource = self
        self.tvOrder.delegate = self
        self.tvOrder.separatorStyle = .none
        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
        
        if ShareOrder.cartOrder == false {
            lblTotalCount.text = "총 \(ShareOrder.orderCount) 개"
            lblTotalPrice.text = DecimalWon(value: (ShareOrder.orderPrice + ShareOrder.orderPersonalPrice) * ShareOrder.orderCount)
        }else {
            let cartCountModel = CartCountModel()
            cartCountModel.delegate = self
            cartCountModel.downloadItems()
            
            let cartPriceModel = CartPriceModel()
            cartPriceModel.delegate = self
            cartPriceModel.downloadItems()
        }
    }

    @IBAction func btnCard(_ sender: UIButton) {
        btnCard.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        btnAccount.layer.borderColor = UIColor.systemGray5.cgColor
        btnGift.layer.borderColor = UIColor.systemGray5.cgColor
        
        ivCard.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
        ivAccount.tintColor = UIColor.darkGray
        ivGift.tintColor = UIColor.darkGray
        
        lblMessage.text = ""
    }
    
    @IBAction func btnAccount(_ sender: UIButton) {
        btnCard.layer.borderColor = UIColor.systemGray5.cgColor
        btnAccount.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        btnGift.layer.borderColor = UIColor.systemGray5.cgColor
        
        ivCard.tintColor = UIColor.darkGray
        ivAccount.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
        ivGift.tintColor = UIColor.darkGray
        
        lblMessage.text = ""
    }
 
    @IBAction func btnGift(_ sender: UIButton) {
        btnCard.layer.borderColor = UIColor.systemGray5.cgColor
        btnAccount.layer.borderColor = UIColor.systemGray5.cgColor
        btnGift.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        
        ivCard.tintColor = UIColor.darkGray
        ivAccount.tintColor = UIColor.darkGray
        ivGift.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
        
        lblMessage.text = "기프트 카드 잔액 : 6,000 원"
    }
    
    func DecimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + " 원"
            
            return result
    }
    
    @IBAction func btnOrder(_ sender: UIButton) {
        
        
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

extension DrinkOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as! DrinkOrderTableViewCell
        
        if ShareOrder.cartOrder == false {
            cell.lblName.text = ShareOrder.orderName
            cell.lblCount.text = "\(ShareOrder.orderCount) 개"
            cell.lblPrice.text = DecimalWon(value: (ShareOrder.orderPrice + ShareOrder.orderPersonalPrice) * ShareOrder.orderCount)
            
            let firstIndex = ShareOrder.orderPersonal.index(ShareOrder.orderPersonal.startIndex, offsetBy: 0)
            let lastIndex = ShareOrder.orderPersonal.index(ShareOrder.orderPersonal.startIndex, offsetBy: ShareOrder.orderPersonal.count-2)
            cell.lblContent.text = String(ShareOrder.orderPersonal[firstIndex..<lastIndex])
            
            let url = URL(string: "\(ShareOrder.orderImg)")
            let data = try? Data(contentsOf: url!)
            cell.ivDrink.layer.cornerRadius = cell.ivDrink.frame.height / 2
            cell.ivDrink.clipsToBounds = true
            cell.ivDrink.image = UIImage(data: data!)
        }else {
            let item: CartModel = dataItem[indexPath.row] as! CartModel
            cell.lblName.text = item.name!
            cell.lblCount.text = "\(item.cartCount!) 개"
            cell.lblPrice.text = DecimalWon(value: (item.price! + item.cartPersonalPrice!) * item.cartCount!)
            
            let firstIndex = item.cartPersonal!.index(item.cartPersonal!.startIndex, offsetBy: 0)
            let lastIndex = item.cartPersonal!.index(item.cartPersonal!.startIndex, offsetBy: item.cartPersonal!.count-2)
            cell.lblContent.text = String(item.cartPersonal![firstIndex..<lastIndex])
            
            let url = URL(string: "\(item.img!)")
            let data = try? Data(contentsOf: url!)
            cell.ivDrink.layer.cornerRadius = cell.ivDrink.frame.height / 2
            cell.ivDrink.clipsToBounds = true
            cell.ivDrink.image = UIImage(data: data!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ShareOrder.cartOrder == false {
            return 1
        }else {
            return dataItem.count
        }
    }

}
 
extension DrinkOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension DrinkOrderViewController : CartSelectModelProtocol {
    func itemDownloaded(items: NSArray) {
        dataItem = items
        self.tvOrder.reloadData()
    }
}

extension DrinkOrderViewController : CartCountModelProtocol {
    func itemDownloaded(items: NSMutableArray) {
        count = items
        let item: PersonalModel = count[0] as! PersonalModel
        lblTotalCount.text = "총 \(item.cartCount!) 개"
    }
}

extension DrinkOrderViewController : CartPriceModelProtocol {
    func priceDownloaded(items: NSMutableArray) {
        price = items
        let item: CartModel = price[0] as! CartModel
        lblTotalPrice.text = DecimalWon(value: item.totalPrice!)
    }
}

extension DrinkOrderViewController : GiftPriceModelProtocol {
    func giftPriceDownloaded(items: NSMutableArray) {
        giftPrice = items
        let item: GiftModel = giftPrice[0] as! GiftModel
        lblMessage.text = "기프트 카드 잔액 : \(DecimalWon(value: Int(item.price!)!))"
    }
}
