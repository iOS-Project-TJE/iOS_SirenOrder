//
//  MapViewController.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/30.
//  Created by biso on 2021/08/04.

import UIKit
import MapKit


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var allLocationList: NSArray = NSArray() // 양서린_location data Array

    let myLoc = CLLocationManager()
    var nowlat:Double = 0
    var nowlon:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let locationList = LocationList()
        locationList.delegate = self
        locationList.downloadItems()
        
        myLoc.delegate = self
        myLoc.requestWhenInUseAuthorization() // 승인 허융 받아 처리
        mapView.showsUserLocation =  true
        myLoc.startUpdatingLocation()
        // Do any additional setu!p after loading the view.
    }
    
    func setLocationPin() {
        for i in 0..<allLocationList.count {
            let item: LocationModel = allLocationList[i] as! LocationModel
            mapMove(item.lat!, item.lon!, item.storename!, item.address!)
        }
    }
    
    func setPoint(_ loc: CLLocationCoordinate2D, _ txt1: String, _ txt2: String) {
        let pin = MKPointAnnotation()
        
        pin.coordinate = loc
        pin.title = txt1
        pin.subtitle = txt2
        
        mapView.addAnnotation(pin)
        
    }
    func mapMove(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees, _ txt1: String, _ txt2: String) {

        
     
        //현재 지도를 좌표 정보로 보이기
        if txt2 == "" {
            let pLoc = CLLocationCoordinate2DMake(lat, lon)
            // 배율
            let pSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            //좌표 정보
            let pRegion = MKCoordinateRegion(center: pLoc, span: pSpan)
            
            mapView.setRegion(pRegion, animated: true)
        }else {
//            let pLoc = CLLocationCoordinate2DMake(lat, lon)
//            setPoint(pLoc, txt1, txt2)
        }
    
        
    }

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLoc = locations.last
        // 지도 보기
        nowlat = (lastLoc?.coordinate.latitude)!
        nowlon = (lastLoc?.coordinate.longitude)!
        myLoc.stopUpdatingLocation() // 좌표 받기 중지
        
        
    }
}

extension MapViewController: LocationListProtocol {
    func itemDownloaded(items: NSArray) {
        allLocationList = items
        setLocationPin()
    
    }
    
}
extension MKAnnotationView {

    public func set(image: UIImage, with color : UIColor) {
        let view = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        view.tintColor = color
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        guard let graphicsContext = UIGraphicsGetCurrentContext() else { return }
        view.layer.render(in: graphicsContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = image
    }
    
}
