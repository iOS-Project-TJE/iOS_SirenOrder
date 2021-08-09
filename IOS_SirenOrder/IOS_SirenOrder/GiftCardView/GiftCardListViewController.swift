//
//  GiftTab2ViewController.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/02.
//

import UIKit

class GiftCardListViewController: UIViewController{

    var paidCardList: NSArray = NSArray() // 양서린_card data Array

    
    @IBOutlet weak var cardListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let paidCardList = PaidCardList()
        paidCardList.delegate = self
        paidCardList.downloadItems("\(userId)")
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
extension GiftCardListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return paidCardList.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("여기요 \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "giftCardListCell", for: indexPath) as! CardPayListTableViewCell

        var item: GiftModel = GiftModel.init()
        item = paidCardList[indexPath.row] as! GiftModel

        let url = URL(string: item.img!)
        let data = try? Data(contentsOf: url!)
        cell.cardImgView.image = UIImage(data: data!)

        cell.lblCardName?.text = "\(item.name ?? "스타벅스 카드")"
        cell.lblPayDate?.text = "\(item.payDate ?? "")"
        cell.lblPrice?.text = "\(item.price ?? "10000")원"

        return cell
    }
}
extension GiftCardListViewController: PaidCardListProtocol {
    func itemDownloaded(items: NSArray) {
        paidCardList = items
        
        cardListTableView.delegate = self
        cardListTableView.dataSource = self
        cardListTableView.rowHeight = 130
    }
    
}
