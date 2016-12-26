//
//  ViewController.swift
//  SwiftMap
//
//  Created by zerlinda on 2016/12/19.
//  Copyright © 2016年 zerlinda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let user = dicToModel()
        print(user.name)
        let dic = modelToDic()
        print(dic)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func modelToDic()->[String:AnyObject]!{
        let user = User()
        user.id = "1001"
        user.name = "王一"
        user.headImage = "qwe"
        let career1 = Career()
        career1.companyCnName = "有限公司"
        career1.companyShortName = "上海公司"
        career1.position = "开发公司"
        career1.timeString = "2010-2011"
        let career2 = Career()
        career2.companyCnName = "科技公司"
        career2.companyShortName = "上海公司"
        career2.position = "开发公司"
        career2.timeString = "2010-2011"
        user.careers = [career1,career2]
        let dic = user.keyValues
        return dic
    }
    
    func dicToModel()->User{
        var userDic:[String:AnyObject] = ["id":"1001" as AnyObject,"name":"王一" as AnyObject,"headImage":"qwe" as AnyObject]
        let careerDic1 = ["companyCnName":"上海有限公司","companyShortName":"上海公司","position":"开发公司","timeString":"2010-2011"]
        let careerDic2 = ["companyCnName":"上海有限公司","companyShortName":"上海公司","position":"开发公司","timeString":"2010-2011"]
        userDic["careers"] = [careerDic1,careerDic2] as AnyObject
        let user = User.objectWithKeyValues(userDic as NSDictionary) as! User
        return user
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

