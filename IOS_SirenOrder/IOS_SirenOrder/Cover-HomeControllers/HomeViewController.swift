//
//  HomeViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/01.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var titleBackgrund: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleBackgrund.setGradient(color1: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), color2: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))

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

