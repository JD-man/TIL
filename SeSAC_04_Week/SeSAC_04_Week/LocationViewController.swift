//
//  LocationViewController.swift
//  SeSAC_04_Week
//
//  Created by JD_MacMini on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI // iOS15 Location Button

/*
 1. 설정 유도
 2. 위경도 -> 주소 변환
 3.
 */

class LocationViewController: UIViewController {

    @IBOutlet weak var userCurrentLocationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // 1.
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        userCurrentLocationLabel.backgroundColor = .red
        userCurrentLocationLabel.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.userCurrentLocationLabel.alpha = 1
        }
        
        // 37.56201112067479, 127.03849387050872
        
        mapView.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: 37.56201112067479, longitude: 127.03849387050872)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "HERE!"
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
        
        // 맵뷰에 어노테이션을 삭제하고자 할 때 (새로운 핀을 찍을때 모두 삭제하고 새로운 핀을 찍어야되서 필요함)
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        // 2.
        locationManager.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}

extension LocationViewController: MKMapViewDelegate {
    // 핀 선택시 동작하는 메서드
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        showAlert(title: "위치 권한 없음", message: "위치가 표시 안됩니다", okTitle: "확인") {
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:]) { success in
                    print("잘 열렸다 \(success)")
                }
            }
        }
    }
}

// 3.
extension LocationViewController: CLLocationManagerDelegate {
    
    // 9. iOS 버전에 따른 분기처리, 시스템에서 위치 서비스 가능 여부 확인
    
    func checkUserLocationServiceAuthorization() {
        
        let authStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authStatus = locationManager.authorizationStatus // iOS14 이상
        }
        else {
            authStatus = CLLocationManager.authorizationStatus() // iOS14 미만
        }
        
        // iOS 시스템 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            // 권한 상태 확인 및 권한 (8번 메서드 실행)
            checkCurrentLocationAuthorization(authStatus: authStatus)
        }
        else {
            print("alert: iOS 위치 서비스를 켜주세요")
        }
        
        
    }
    
    // 8. 사용자의 권한 상태 확인(UDF, 사용자 정의 함수. 프로토콜 메서드가 아님)
    // 사용자가 위치를 허용했는지 안했는지 거부한건지 등 권한 확인 (단, 이거에 앞서 iOS 위치 서비스가 가능한지 확인)
    func checkCurrentLocationAuthorization(authStatus: CLAuthorizationStatus) {
        switch authStatus {
        case .notDetermined:
            // locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // plist에서 wheninuse를 사용해서 이거로 요청하는거임
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청. notDetermined 때만 사용됨
            locationManager.startUpdatingLocation() // 위치 접근 시작, didUpdateLocations 실행
        case .restricted, .denied:
            print("DENIED, 설정으로 유도")
        case .authorizedAlways:
            print("얘도 안씀")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // 위치 접근 시작, didUpdateLocations 실행
//        case .authorized:
//            요즘은 안쓰는 부분
        @unknown default: // @unknown 알아보기
            print("DEFAULT")
        }
        
        if #available(iOS 14.0, *) {
            // 정확도 체크: 정확도 감소 되어 있는 경우, 제대로 동작하지 않는 앱이 있음. 배터리는 오래쓰긴함.
            let accuracyState = locationManager.accuracyAuthorization
            
            switch accuracyState {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                print("REDUCE, 알림 등이 제대로 안갈수 있다고 alert 할 필요가있음")
            @unknown default:
                print("DEFAULT")
            }
        }
        
    }
    
    // 4. 사용자가 위치 허용을 하는 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
        
        if let coordinate = locations.last?.coordinate {
            // pin 찍기
            let annotation = MKPointAnnotation()
            annotation.title = "Current Location"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            // 10. (중요) 계속 업데이트 안되게 중단요청
            locationManager.stopUpdatingLocation()
        }
        else {
            print("Location CanNot Find")
        }
    }
    
    // 5. 위치 접근에 실패한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    // 6. iOS14 미만: 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 상태를 알려줌.
    // 권한이 변경될 때 마다 감지해서 실행이 됨.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServiceAuthorization()
    }
    
    // 7. iOS14 이상: 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 상태를 알려줌.
    // 권한이 변경될 때 마다 감지해서 실행이 됨.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServiceAuthorization()
    }
}
