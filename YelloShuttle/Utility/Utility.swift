//
//  Utility.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/10/23.
//

import Foundation
import UIKit

class Utilities {
    /**
     * @brief :  Password valid check
     * @param :  String
     * @return :  Bool
     * @see : -
     * @author : Jungwon Cha
     * @date :  2020/10/23
     */
    static func isPasswordValid(_ password: String) -> Bool {
        let pwd = NSPredicate(format: "SELF MATCHES %@",
                                   "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,12}")
        return pwd.evaluate(with: password)
    }


}
