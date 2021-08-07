//
//  OtherTableViewController.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/29.
//

import UIKit

class OtherTableViewController: UITableViewController {
    @IBOutlet var listTableView: UITableView!
    
    let serviceList=["알림","e-기프트 카드","히스토리","전자영수증"]
    let serviceList2=["NoticeTable","GiftCard","History","Receipt"]
    let helpList=["고객의 소리","매장 정보"]
    let helpList2=["QnA","Map"]
    let policyList=["이용약관","개인정보 처리 방침"]
    let policyList2=["Manual","Personal"]
    let sectionList=["","서비스","고객 지원","약관 및 정책"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .gray
        self.navigationItem.backBarButtonItem = backBarButtonItem

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section]
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let myLabel = UILabel()
            myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
            myLabel.font = UIFont.boldSystemFont(ofSize: 18)
            myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

            let headerView = UIView()
            headerView.addSubview(myLabel)

            return headerView
//            let header = view as? UITableViewHeaderFooterView
//            header?.textLabel?.textColor = UIColor.red
//            header?.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//            header?.textLabel?.textAlignment = .center
//            return header
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 0
        case 1:
            return serviceList.count
        case 2:
            return helpList.count
        case 3:
            return policyList.count
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell", for: indexPath)

        // Configure the cell...
        switch indexPath.section{
        case 0:
            break
        case 1:
            cell.textLabel?.text=serviceList[indexPath.row]
        case 2:
            cell.textLabel?.text=helpList[indexPath.row]
        case 3:
            cell.textLabel?.text=policyList[indexPath.row]
        default:
            break
        }
        cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case 0:
            break
        case 1:
            self.performSegue(withIdentifier: "\(serviceList2[indexPath.item])ViewController", sender: self)
        case 2:
            self.performSegue(withIdentifier: "\(helpList2[indexPath.item])ViewController", sender: self)
        case 3:
            self.performSegue(withIdentifier: "\(policyList2[indexPath.item])ViewController", sender: self)
        default:
            break
        }
               
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
