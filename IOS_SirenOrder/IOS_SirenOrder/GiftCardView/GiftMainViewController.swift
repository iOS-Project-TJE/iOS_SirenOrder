//
//  GiftMainViewController.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/02.
//

import UIKit
import Tabman
import Pageboy


class GiftMainViewController: TabmanViewController {
    
    var viewControllers: Array<UIViewController> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "giftItems") as! GiftCardItemViewController
        let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "giftLists") as! GiftCardListViewController

       viewControllers.append(vc2)
       viewControllers.append(vc3)
        
        self.dataSource = self

        // Create bar
        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar) //함수 추후 구현
        addBar(bar, dataSource: self, at: .top)
        // Do any additional setup after loading the view.
    }
    

    /* 필수 변경사항
     tab bar
     1.간격 조절하기
     2.색상 변경하기
    */
    
    func settingTabBar (ctBar : TMBar.ButtonBar) {
        ctBar.layout.transitionStyle = .snap
        // 왼쪽 여백주기
        ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        // 간격
        ctBar.layout.interButtonSpacing = 0
            
        ctBar.backgroundView.style = .blur(style: .light)
        
        // 선택 / 안선택 색 + font size
        ctBar.buttons.customize { (button) in
            button.tintColor = UIColor.black
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 16)
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        
        // 인디케이터
        ctBar.indicator.weight = .custom(value: 2)
        ctBar.indicator.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
    }

}
extension GiftMainViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
   
        // MARK: -Tab 안 글씨들
        switch index {
        case 1:
            return TMBarItem(title: "\t\t\t선물내역\t\t\t   ")
        default:
            return TMBarItem(title: "\t\t\t선물하기\t\t\t")
        }

    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        //위에서 선언한 vc array의 count를 반환합니다.
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

