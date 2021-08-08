//
//  HomeViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/01.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblrecommend: UILabel!
    @IBOutlet weak var titleBackgrund: UIImageView!
    @IBOutlet weak var cv_recommend: UICollectionView!
    @IBOutlet weak var cv_new: UICollectionView!
    @IBOutlet weak var cv_best: UICollectionView!
    
    var recommendItem: NSArray = NSArray()
    var newItem: NSArray = NSArray()
    var bestItem: NSArray = NSArray()
    var indexPath = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lblName.text = "\(UserDefaults.standard.object(forKey: "userNickname")!)님,"
       // lblrecommend.text = "\(UserDefaults.standard.object(forKey: "userNickname")!)님을 위한 추천 메뉴"
        
        //모델 연결작업
        let HomeRecommendModel = HomeRecommendModel()
        let HomeNewModel = HomeNewModel()
        let HomeBestModel = HomeBestModel()
        
        HomeRecommendModel.delegate = self
        HomeRecommendModel.downloadItems()
        
        HomeNewModel.delegate = self
        HomeNewModel.downloadItems()

        HomeBestModel.delegate = self
        HomeBestModel.downloadItems()
          
        cv_recommend.delegate = self
        cv_recommend.dataSource = self
        
        cv_new.delegate = self
        cv_new.dataSource = self
        
        cv_best.delegate = self
        cv_best.dataSource = self
        
        titleBackgrund.setGradient(color1: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), color2: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
       
    }
    
    
    //다시 되돌아 올 경우 리로드
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        cv_recommend.reloadData()
        cv_new.reloadData()
        cv_best.reloadData()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! HomeCollectionViewCell
        
        if segue.identifier == "sgRecommend" {
            //추천 컬렉션뷰에서 클릭힐경우
            let indexPath = self.cv_recommend.indexPath(for: cell)
            let item: DrinkModel = recommendItem[indexPath!.row] as! DrinkModel
            let drinkDetailViewController = segue.destination as! DrinkDetailViewController
            drinkDetailViewController.receivedCd = item.cd!
            
        }else if segue.identifier == "sgNew" {
            //뉴 컬렉션 뷰에서 클릭할경우
            let indexPath = self.cv_new.indexPath(for: cell)
            let item: DrinkModel = newItem[indexPath!.row] as! DrinkModel
            let drinkDetailViewController = segue.destination as! DrinkDetailViewController
            drinkDetailViewController.receivedCd = item.cd!
            
        }else {
            //베스트 컬렉션뷰에서 클릭힐경우
            let indexPath = self.cv_best.indexPath(for: cell)
            let item: DrinkModel = bestItem[indexPath!.row] as! DrinkModel
            let drinkDetailViewController = segue.destination as! DrinkDetailViewController
            drinkDetailViewController.receivedCd = item.cd!
            
            
        }
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
//상단 그라데이션 이미지
extension UIView{
    func setGradient(color1:UIColor,color2:UIColor){
        let gradient = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}

//컬렉션뷰 정의
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Cell 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case cv_recommend:
            return recommendItem.count
        case cv_new:
            return newItem.count
        case cv_best:
            return bestItem.count
        default:
            return 0
        }
    }
    
    //Cell 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        
        switch collectionView {
        case cv_recommend:
            let item: DrinkModel = recommendItem[indexPath.row] as! DrinkModel
            let url = URL(string:"\(item.img!)")
            let data = try? Data(contentsOf: url!)
            cell.image.image = UIImage(data: data!)
            cell.image.layer.cornerRadius = cell.image.frame.height / 2
            cell.image.clipsToBounds = true
            cell.name.text = item.name!
            
        case cv_new:
            let item: DrinkModel = newItem[indexPath.row] as! DrinkModel
            
            let url = URL(string:"\(item.img!)")
            let data = try? Data(contentsOf: url!)
            cell.image.image = UIImage(data: data!)
            cell.image.layer.cornerRadius = cell.image.frame.height / 2
            cell.image.clipsToBounds = true
            cell.name.text = item.name!
            
        case cv_best:
            let item: DrinkModel = bestItem[indexPath.row] as! DrinkModel
            let url = URL(string:"\(item.img!)")
            let data = try? Data(contentsOf: url!)
            cell.image.image = UIImage(data: data!)
            cell.image.layer.cornerRadius = cell.image.frame.height / 2
            cell.image.clipsToBounds = true
            cell.name.text = item.name!
            
        default :
            print("fail")
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DrinkDetailVC") as! DrinkDetailViewController
        switch collectionView {
        case cv_recommend:
            let item: DrinkModel = recommendItem[indexPath.row] as! DrinkModel
            vc.receivedCd = item.cd!
         
        case cv_new:
            let item: DrinkModel = newItem[indexPath.row] as! DrinkModel
            vc.receivedCd = item.cd!

        case cv_best:
            let item: DrinkModel = bestItem[indexPath.row] as! DrinkModel
            vc.receivedCd = item.cd!

        default:
            print("fail")
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
            
    }
    
    
    
    
}



//프로토콜 연결
extension HomeViewController : HomeRecommendModelProtocol {
    func itemRecommendDownloaded(items: NSArray) {
        recommendItem = items
      
        if recommendItem.count == 0 {
            let HomeBestModel = HomeBestModel()
            
            HomeBestModel.delegate = self
            HomeBestModel.downloadItems()
        }
        
        self.cv_recommend.reloadData()
    }
}

extension HomeViewController : HomeNewModelProtocol {
    func itemNewDownloaded(items: NSArray) {
        newItem = items
        self.cv_new.reloadData()
    }
}

extension HomeViewController : HomeBestModelProtocol {
    func itemBestDownloaded(items: NSArray) {
        bestItem = items
        
        if recommendItem.count == 0 {
            recommendItem = bestItem
            self.cv_recommend.reloadData()
        }
            
        self.cv_best.reloadData()
    }
}

