//
//  PermissionViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/07/29.
//

import UIKit
import MapKit
import AVKit
import CoreBluetooth

class PermissionViewController: UIViewController {

    @IBOutlet weak var btnOK: UIButton!
    var locationManager:CLLocationManager! // 퍼미션 - 지도
    var centralManager: CBCentralManager! // 퍼미션 - 블루투스

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)


        //버튼 라운드
        btnOK.layer.cornerRadius = 20
    }
        // Do any additional setup after loading the view.
    @IBAction func btnNext(_ sender: Any) {
        
        //locationManager.requestWhenInUseAuthorization() // 위치체크
        requestCameraPermission() // 카메라 체크
        requestMicrophonePermission() // 음성체크

        moveNext()
        
        
    }
    
    //넘어가는 메소드
    func moveNext() {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "ExplainVC") else{
            return
        }

        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical

        self.present(uvc, animated: true)
    }
    
    //카메라 권한
    func requestCameraPermission(){
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                print("Camera: 권한 허용")
            } else {
                print("Camera: 권한 거부")
            }
        })
    }
    
    //음성권한
    func requestMicrophonePermission(){
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                print("Mic: 권한 허용")
            } else {
                print("Mic: 권한 거부")
            }
        })
    }
 

    
    
    
    
}

//블루투스 권한
extension PermissionViewController: CBPeripheralDelegate, CBCentralManagerDelegate {
    //블루투스가 켜진 상태인지 확인. 시스템의 Bluetooth 상태가 변경될 때마다 호출.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {

        case .unknown:
            print("central.state is unknown")
        case .resetting:
            print("central.state is resetting")
        case .unsupported:
            print("central.state is unsupported")
        case .unauthorized:
            print("central.state is unauthorized")
        case .poweredOff:
            print("central.state is poweredOff")
        case .poweredOn:
            print("central.state is poweredOn")
        @unknown default:
            print("central.state default case")
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



