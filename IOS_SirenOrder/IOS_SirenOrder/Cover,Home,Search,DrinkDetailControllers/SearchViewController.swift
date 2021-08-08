//
//  SearchViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/08.
//

import UIKit
import SQLite3

class SearchViewController: UIViewController {

    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var lblNoItem: UILabel!
    @IBOutlet weak var tvSearch: UITableView!
    
    var db: OpaquePointer?
    var searchTextList: [SearchSQLiteModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //SQLite 생성하기
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("searchDatabase.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("DB열기실패")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS search (num INTEGER PRIMARY KEY AUTOINCREMENT, searchtext TEXT)",nil,nil,nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        
        tfSearch.text=""
        tvSearch.delegate = self
        tvSearch.dataSource = self
        readValues()
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        var stmt: OpaquePointer?
        //한글깨짐 방지
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let searchText = tfSearch.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let queryString = "INSERT INTO search (searchtext) VALUES (?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        if sqlite3_bind_text(stmt,1, searchText, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding text: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error inserting search: \(errmsg)")
            return
        }
        
        //페이지 연결작업
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchDetailVC") as! SearchDetailViewController
        
        vc.receivedName = tfSearch.text!
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func readValues(){
        searchTextList.removeAll()
        
        let queryString = "SELECT * FROM search"
        
        var stmt: OpaquePointer?
        
        print("초기화! \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            return
        }
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            let num = sqlite3_column_int(stmt, 0)
            let searchtext = String(cString: sqlite3_column_text(stmt, 1))
            
            searchTextList.append(SearchSQLiteModel(num: Int(num), searchText: String(searchtext)))
        }
        self.tvSearch.reloadData()
        
        if searchTextList.count == 0 {
            searchView.isHidden = true
            lblNoItem.isHidden = false
        }else{
            searchView.isHidden = false
            lblNoItem.isHidden = true
        }
    }
    
    @IBAction func btnAllClear(_ sender: UIButton) {
        
        let queryString = "DELETE FROM search"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            return
        }
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            let num = sqlite3_column_int(stmt, 0)
            let searchtext = String(cString: sqlite3_column_text(stmt, 1))
            
            searchTextList.append(SearchSQLiteModel(num: Int(num), searchText: String(searchtext)))
        }
        self.tvSearch.reloadData()
        
        
        readValues()
        
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
     
        let item: SearchSQLiteModel
        item = searchTextList[sender.tag]
        
        let num = item.num!
        
        let queryString = "DELETE FROM search where num=\(num)"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            return
        }
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            let num = sqlite3_column_int(stmt, 0)
            let searchtext = String(cString: sqlite3_column_text(stmt, 1))
            
            searchTextList.append(SearchSQLiteModel(num: Int(num), searchText: String(searchtext)))
        }
        self.tvSearch.reloadData()
        
        
        readValues()
        
    }

    
}

extension SearchViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTextList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTextCell", for: indexPath) as! SearchTableViewCell
        
        let item: SearchSQLiteModel
        item = searchTextList[indexPath.row]
       
        cell.lblText.text = item.searchText!
        cell.btnX.tag = indexPath.row
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchDetailVC") as!SearchDetailViewController

        let item: SearchSQLiteModel
        item = searchTextList[indexPath.row]

        vc.receivedName = item.searchText!

        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
    
    
    
}
