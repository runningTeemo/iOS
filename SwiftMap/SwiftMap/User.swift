//
//  User.swift
//  SwiftMap
//
//  Created by zerlinda on 2016/12/19.
//  Copyright © 2016年 zerlinda. All rights reserved.
//

import UIKit

class User: NSObject,DictModelProtocol{
    var id:String?
    var name:String?
    var headImage:String?
    var careers:[Career]?
    static func customClassMapping() -> [String : String]? {
        return ["careers":"Career"];
    }
}
