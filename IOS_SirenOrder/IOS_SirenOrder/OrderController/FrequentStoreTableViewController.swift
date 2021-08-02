//
//  FrequentStoreTableViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/02.
//

import UIKit

class FrequentStoreTableViewController: UITableViewController { // 21.08.02 조혜지 Order 자주 가는 매장 Table View
    
    @IBOutlet var tvFrequentStore: UITableView!
    
    var dataItem: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let frequentStoreModel = FrequentStoreModel()
        frequentStoreModel.delegate = self
        frequentStoreModel.downloadItems()
        tvFrequentStore.rowHeight = 96
        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "frequentStoreCell", for: indexPath) as! FrequentStoreTableViewCell

        // Configure the cell...
        // let item = LocationModel
        cell.selectionStyle = .none
        
        let item: LocationModel = dataItem[indexPath.row] as! LocationModel
        
        cell.lblFrequentStoreName.text = "\(item.storename!)"
        cell.lblFrequentStoreAddress.text = "\(item.address!)"

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
        if segue.identifier == "sgFrequentStoreDetail" {
            let cell = sender as! FrequentStoreTableViewCell
            let indexPath = self.tvFrequentStore.indexPath(for: cell)
            let item: LocationModel = dataItem[indexPath!.row] as! LocationModel
            let storeDetailViewController = segue.destination as! StoreDetailViewController
            storeDetailViewController.receivedData(item)
        }
        
    }
    

}

extension FrequentStoreTableViewController : FrequentStoreModelProtocol{
    func itemDownloaded(items: NSArray) {
        dataItem = items
        self.tvFrequentStore.reloadData()
    }
}
