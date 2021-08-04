//
//  StoreSettingViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/07/30.
//

import UIKit
import Tabman
import Pageboy

class StoreSettingViewController: TabmanViewController { // 2021.07.30 조혜지 Order 매장 정보 Tabman 설정

    private var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllStoreTableViewController") as! AllStoreTableViewController
        let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FrequentStoreTableViewController") as! FrequentStoreTableViewController
            
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        
        self.dataSource = self

        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap

        addBar(bar, dataSource: self, at: .top)
        
        bar.backgroundView.style = .blur(style: .regular)
        
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray
            button.selectedTintColor = .black
        }
        
        bar.indicator.weight = .light
        bar.indicator.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
        
        bar.indicator.overscrollBehavior = .compress
        
        bar.indicator.overscrollBehavior = .bounce
        
        navigationItem.largeTitleDisplayMode = .never
        
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

extension StoreSettingViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        if index == 0 {
            item.title = "가까운 매장"
        }else {
            item.title = "자주 가는 매장"
        }
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
