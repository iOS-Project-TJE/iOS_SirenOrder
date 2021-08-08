//
//  SettingTableViewController.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/08/06.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    let settingsectionList=["","계정 정보","권한 설정","기타 관리"]
    let accountList=["로그아웃","회원 탈퇴"]
    let permissionList=["푸시 알림","위치 정보 서비스 이용약관 동의"]
    let otherSettingList=["버전 정보"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return settingsectionList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsectionList[section]
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let myLabel = UILabel()
            myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
            myLabel.font = UIFont.boldSystemFont(ofSize: 18)
            myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

            let headerView = UIView()
            headerView.addSubview(myLabel)

            return headerView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 0
        case 1:
            return accountList.count
        case 2:
            return permissionList.count
        case 3:
            return otherSettingList.count
        default:
            return 0
        }
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        
        cell.detailTextLabel?.text=">"
        cell.detailTextLabel?.textColor=#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        switch indexPath.section{
        case 0:
            break
        case 1:
            if indexPath.row == 0{
                cell.textLabel?.text = "계정 전환"
                cell.detailTextLabel?.text = accountList[indexPath.row]
                cell.detailTextLabel?.textColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
                cell.detailTextLabel?.layer.cornerRadius = 10
                cell.detailTextLabel?.layer.borderWidth = 1.2
                cell.detailTextLabel?.layer.borderColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
            }else{
                cell.textLabel?.text=accountList[indexPath.row]
            }
        case 2:
            cell.textLabel?.text=permissionList[indexPath.row]
        case 3:
            cell.textLabel?.text=otherSettingList[indexPath.row]
            cell.detailTextLabel?.text="21.3.1  >"
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
            switch indexPath.item{
            case 0 :
                Logout()
            case 1:
                memberDelete()
            default:
                break
            }
        case 2:
            Logout()
        case 3:
            self.performSegue(withIdentifier: "versionDetail", sender: self)
        default:
            break
        }
               
    }
    
    func Logout(){
        let green:UIColor=#colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        
        let testAlert=UIAlertController(title: "로그아웃 하시겠어요?", message: nil, preferredStyle: .alert)
        
        let actionDefault=UIAlertAction(title: "확인", style: .default, handler: {ACTION in
            print("로그아웃됨!")
        })
        let actionCanceled=UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionDefault.setValue(green, forKey: "titleTextColor")
        actionCanceled.setValue(green, forKey: "titleTextColor")
        
        testAlert.addAction(actionDefault)
        testAlert.addAction(actionCanceled)
        
        present(testAlert, animated: true, completion: nil)
    }
    
    func memberDelete(){
        let green:UIColor=#colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        
        let testAlert=UIAlertController(title: "회원 탈퇴는 홈페이지에서 가능합니다.", message: nil, preferredStyle: .alert)
        
        let actionDefault=UIAlertAction(title: "확인", style: .default, handler: {ACTION in
            self.performSegue(withIdentifier: "memberDelete", sender: self)
        })
        let actionCanceled=UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionDefault.setValue(green, forKey: "titleTextColor")
        actionCanceled.setValue(green, forKey: "titleTextColor")
        
        testAlert.addAction(actionDefault)
        testAlert.addAction(actionCanceled)
        
        present(testAlert, animated: true, completion: nil)
    }

}
