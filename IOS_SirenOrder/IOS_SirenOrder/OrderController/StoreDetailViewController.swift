//
//  StoreDetailViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/02.
//

import UIKit
import MapKit

class StoreDetailViewController: UIViewController {
    
    var list: NSArray = NSArray()

    @IBOutlet weak var mapStoreDetail: MKMapView!
    @IBOutlet weak var lblStoreDetailAddress: UILabel!
    @IBOutlet weak var btnStoreCheckShape: UIButton!
    
    var name: String = ""
    var lat: Double = 0.0
    var long: Double = 0.0
    let myLoc = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoSetting()
        
        btnStoreCheckShape.layer.cornerRadius = 20
        navigationItem.title = name
        
        myLoc.requestWhenInUseAuthorization()
        mapMove(lat, long, name)
    }
    
    func receivedData(_ receivedData: LocationModel) {
        list = [receivedData]
    }
    
    func infoSetting() {
        let item: LocationModel = list[0] as! LocationModel
        lblStoreDetailAddress.text = item.address
        name = item.storename!
        lat = item.lat!
        long = item.lon!
    }
    
    func mapMove(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees, _ txt1: String) {
        let pLoc = CLLocationCoordinate2DMake(lat, lon)
        let pSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let pRegion = MKCoordinateRegion(center: pLoc, span: pSpan)
        mapStoreDetail.setRegion(pRegion, animated: true)
        setPin(pLoc, txt1)
    }
    
    func setPin(_ loc: CLLocationCoordinate2D, _ txt1: String) {
        let pin = MKPointAnnotation()
        pin.coordinate = loc
        pin.title = txt1
        mapStoreDetail.addAnnotation(pin)
    }

    @IBAction func btnStoreCheck(_ sender: UIButton) {
        storeName = name
        if goOrder == false && goCart == false {
            navigationController?.popToRootViewController(animated: true)
        }else if goOrder == true {
            self.performSegue(withIdentifier: "sgOrder", sender: self)
        }else if goCart == true {
            self.performSegue(withIdentifier: "sgCart", sender: self)
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
