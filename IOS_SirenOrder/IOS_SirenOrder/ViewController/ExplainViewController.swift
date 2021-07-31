//
//  ExplainViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/07/29.
//

import UIKit

class ExplainViewController: UIViewController {

    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imgLeft = [UIImage]()
    var imgRight = [UIImage]()
    
    var images = ["ex1.png","ex2.png","ex3.png"]
    var count = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imgView.image = UIImage(named: images[0])
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
       
        makeSingleTouch()
        
        btnOK.isHidden = true
        
    }
    @IBAction func pageChange(_ sender: UIPageControl) {
        
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
    
    func makeSingleTouch(){
       
        //left
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ExplainViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        //right
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ExplainViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
           
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                pageControl.currentPage += 1
                imgView.image = UIImage(named: images[pageControl.currentPage])
                
                if count < 2 {
                    count += 1
                }
                
            case UISwipeGestureRecognizer.Direction.right:
                pageControl.currentPage -= 1
                imgView.image = UIImage(named: images[pageControl.currentPage])
                
                if count > 0  {
                    count -= 1
                }
                
            default:
                break
            }
            
            //스킵,확인 버튼 표시
            if count == 2 {
                btnSkip.isHidden = true
                btnOK.isHidden = false
            }else {
                btnSkip.isHidden = false
                btnOK.isHidden = true
            }
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
