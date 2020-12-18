//
//  DriverInfo.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/11/05.
//

import UIKit

//struct DriverInfo {
//    var driverPicture: UIImage
//    var driverName: String
//    var driverNumber: String
//    var driverCarNumber: String
//    var academy: String
//}

class DriverInfo {
    var driverPicture: UIImage!
    var driverName: String!
    var driverNumber: String!
    var driverCarNumber: String!
    var academy: String!
    
    init(driverPicture: UIImage, driverName: String, driverNumber: String, driverCarNumber: String, academy: String) {
        self.driverPicture = driverPicture
        self.driverName = driverName
        self.driverNumber = driverNumber
        self.driverCarNumber = driverCarNumber
        self.academy = academy
    }
}
