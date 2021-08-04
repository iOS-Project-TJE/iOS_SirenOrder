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
    
    
    func setPoint(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees, _ txt1: String, _ txt2: String) {
        let pin = MKPointAnnotation()
        let pLoc = CLLocationCoordinate2DMake(lat, lon)
        pin.coordinate = pLoc
        pin.title = txt1
        pin.subtitle = txt2
        
        mapView.addAnnotation(pin)
        
    }
    func mapMove(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees) {
            let pLoc = CLLocationCoordinate2DMake(lat, lon)
            // 배율
            let pSpan = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
            //좌표 정보
            let pRegion = MKCoordinateRegion(center: pLoc, span: pSpan)
            mapView.setRegion(pRegion, animated: true)
    }

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLoc = locations.last
        // 지도 보기
        mapMove((lastLoc?.coordinate.latitude)!, (lastLoc?.coordinate.longitude)!)
        myLoc.stopUpdatingLocation() // 좌표 받기 중지
        
    }
}

extension MapViewController: LocationListProtocol {
    func itemDownloaded(items: NSArray) {
        allLocationList = items
        for i in 0..<allLocationList.count {
            let item: LocationModel = allLocationList[i] as! LocationModel
            setPoint(item.lat!, item.lon!, item.storename!, item.address!)
        }

    }
    
}
