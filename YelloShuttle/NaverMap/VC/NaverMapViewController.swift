//
//  NaverMapViewController.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/10/27.
//

import UIKit
import NMapsMap
//import Alamofire
//import SwiftyJSON

public let DEFAULT_CAMERA_POSITION = NMFCameraPosition(NMGLatLng(lat:36.356302, lng: 127.341909),
                                                       zoom: 14,        // 숫자 클수록 최대
                                                       tilt: 0,     // 0 : 지면을 수직으로 봄
                                                       heading: 0)  // 0 : 정북, 90 : 동, 180 : 남, 270 : 서

class NaverMapViewController: UIViewController {

    // MARK:- Properties
    // MARK: IBOutlets for RideInfo List
    @UseAutoLayout var buttonView = UIView()
    @UseAutoLayout var registerButton = UIButton()
    @UseAutoLayout var listButton = UIButton()
    @UseAutoLayout var modifyButton = UIButton()
    
    // MARK: for Naver Map View
    @UseAutoLayout var naverMapView = NMFNaverMapView()
    @UseAutoLayout var centerMark = UIImageView()
    
    lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "탑승유무", style: .plain, target: self, action: #selector(onClickBarButtonItems(_:)))
        btn.tag = 0
        return btn
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "탑승완료", style: .plain, target: self, action: #selector(onClickBarButtonItems(_:)))
        btn.tag = 1
        return btn
    }()
    
    // MARK: 경로 주소 저장용
    var rAddr: String = "대전광역시"     // 도로명
    var lAddr: String = "대전광역시"     // 지번
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "탑승정보"
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
        
        viewNaverMap()
    }
    
    // MARK:- Private Method
    // MARK:- Private Funcs
   
    // MARK:- Selectors
    @objc func onClickBarButtonItems(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            print(#line)
        case 1:
            print(#line)
        default:    break
        }
    }
    // MARK:- UIView
    /**
     * @brief :  Naver Map View & 옵션 설정
     * @param :  -
     * @return :  -
     * @see : -
     * @author : Jungwon Cha
     * @date :  2020/11/02
     */
    private func viewNaverMap() {
        view.addSubview(naverMapView)
        
        naverMapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naverMapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naverMapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        naverMapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        naverMapView.mapView.moveCamera(NMFCameraUpdate(position: DEFAULT_CAMERA_POSITION))
        naverMapView.mapView.positionMode = .normal     // 위치만 움직임 / 위치추적 + 카메라도 같이 움직임 : .direction
        
        naverMapView.mapView.minZoomLevel = 5.0     // zoom level limit min
        naverMapView.mapView.maxZoomLevel = 18.0    // zoom level limit max
        naverMapView.mapView.mapType = .basic       // Map Type : Basic, Navi, Satellite etc
        naverMapView.mapView.extent = NMGLatLngBounds(southWestLat: 31.43, southWestLng: 122.37, northEastLat: 44.35, northEastLng: 132)    // Camera 영역 한반도 인근으로 제한
        
        naverMapView.showScaleBar = false   // 축척바
        naverMapView.showLocationButton = true  // 현위치 버튼
        naverMapView.showZoomControls = true    // 지도 확대/축소 버튼
    
        setCenterMark()
    }
    
    /**
     * @brief :  Center Mark Image
     * @param :  -
     * @return :  -
     * @see : -
     * @author : Jungwon Cha
     * @date :  2020/11/02
     */
    private func setCenterMark() {
        naverMapView.addSubview(centerMark)
        
        centerMark.image = UIImage(named: "centerMark")
        centerMark.frame.size = CGSize(width: 40, height: 53)
        centerMark.centerXAnchor.constraint(equalTo: naverMapView.centerXAnchor).isActive = true
        centerMark.centerYAnchor.constraint(equalTo: naverMapView.centerYAnchor, constant: -26.5).isActive = true
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

//extension NaverMapViewController : TestProtocol {
//    func setRideInfo(rideinfo: String, detail: String) {
//        print(rideinfo, detail)
//        self.title = rideinfo
//    }
//}
