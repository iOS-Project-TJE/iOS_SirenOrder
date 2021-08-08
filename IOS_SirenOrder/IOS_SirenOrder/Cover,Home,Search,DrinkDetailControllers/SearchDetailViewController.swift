//
//  SearchDetailViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/08.
//

import UIKit

class SearchDetailViewController: UIViewController {

    @IBOutlet weak var lblNil: UILabel!
    @IBOutlet weak var tvlist: UITableView!
    
    var searchDrink: NSArray = NSArray()
    var receivedName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "\(receivedName)"
        
        let searchDetailModel = SearchDetailModel()
        searchDetailModel.delegate = self
        searchDetailModel.downloadItems(name: receivedName)
        tvlist.rowHeight = 110
        
        tvlist.delegate = self
        tvlist.dataSource = self
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
extension SearchDetailViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDrink.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchDetailTableViewCell
        
        let item: DrinkModel = searchDrink[indexPath.row] as! DrinkModel
        
        let url = URL(string:"\(item.img!)")
        let data = try? Data(contentsOf: url!)
        
        cell.imageSearch.image = UIImage(data: data!)
        cell.nameSearch.text = item.name!
        cell.priceSearch.text = DecimalWon(value: item.price!)
        cell.imageSearch.layer.cornerRadius = cell.imageSearch.frame.height / 2
        cell.imageSearch.clipsToBounds = true
      
        return cell
    }
    
    //금액
    func DecimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + " 원"
            
            return result
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DrinkDetailVC") as! DrinkDetailViewController
        
        let item: DrinkModel = searchDrink[indexPath.row] as! DrinkModel
        vc.receivedCd = item.cd!
        
        self.navigationController?.pushViewController(vc, animated: true)
            
    }
    
    
    
    
    
    
}

extension SearchDetailViewController : SearchDetailModelProtocol {
    func itemDownloaded(items: NSArray) {
        searchDrink = items
        if searchDrink.count == 0 {
            lblNil.isHidden = false
            tvlist.isHidden = true
        }else {
            lblNil.isHidden = true
            tvlist.isHidden = false
            }
        self.tvlist.reloadData()
    }
   
}

