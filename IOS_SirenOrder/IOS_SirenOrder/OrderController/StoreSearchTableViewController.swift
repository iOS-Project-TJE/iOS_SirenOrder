//
//  StoreSearchTableViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/03.
//

import UIKit

class StoreSearchTableViewController: UITableViewController { // 21.08.03 조혜지 Order 매장 검색 결과 Table View

    @IBOutlet var tvSearchStore: UITableView!
    
    var dataItem: NSMutableArray = NSMutableArray()
    var receivedSearchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationItem.title = "\(receivedSearchText)"
        
        let storeSearchModel = StoreSearchModel()
        storeSearchModel.delegate = self
        storeSearchModel.downloadItems(searchText: receivedSearchText)
        tvSearchStore.rowHeight = 96
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataItem.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeSearchCell", for: indexPath) as! StoreSearchTableViewCell

        cell.selectionStyle = .none
        
        let item: LocationModel = dataItem[indexPath.row] as! LocationModel
        
        cell.lblStoreSearchName.text = "\(item.storename!)"
        cell.lblStoreSearchAddress.text = "\(item.address!)"

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgStoreSearchDetail" {
            let cell = sender as! StoreSearchTableViewCell
            let indexPath = self.tvSearchStore.indexPath(for: cell)
            let item: LocationModel = dataItem[indexPath!.row] as! LocationModel
            let storeDetailViewController = segue.destination as! StoreDetailViewController
            storeDetailViewController.receivedData(item)
        }
    }
    


}

extension StoreSearchTableViewController : StoreSearchModelProtocol {
    func itemDownloaded(items: NSMutableArray) {
        dataItem = items
        self.tvSearchStore.reloadData()
    }
}
