//
//  UserInfo.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/11/25.
//

import UIKit

class UserInfo {
    static let shared = UserInfo()
    
    var driverPicture: UIImage?
    var driverName: String?
    var driverNumber: String?
    var driverCarNumber: String?
    var academy: String?
    
    var rideInfo:[String] = ["노은고등학교", "충남고등학교", "대신고등학교"]
    let detailList = ["01.월평동 입구", "02.A아파트 후문", "03.로얄로드", "04.유성고등학교 앞", "05.도안2블럭 후문", "06.월평동 후문"]
    
    private init() {
        
    }
    
    func inputDriver() {
        driverPicture = UIImage(named: "ksh")!
        driverName = "김수현"
        driverNumber = "010-1234-1234"
        driverCarNumber = "대전33삼1234"
        academy = "별이빛나는밤"
    }

}
