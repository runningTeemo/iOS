//
//  NSObject+DicParseToModel.swift
//  touzhong
//
//  Created by zerlinda on 16/9/6.
//  Copyright © 2016年 zerlinda. All rights reserved.
//

import Foundation
/** 当字典中存在数组， 并且数组中保存的值得类型是字典， 那么就需要指定数组中的字典对应的类类型。
 这里以键值对的形式保存
 eg 字典如下：
 key: [[key1:value1, key2:value2],[key1:value3, key2:value4],[key1:value5, key2:value6]]
 
 key：  key值
 value: 字典[key1:value1, key2:value2] 对应的模型
 */

@objc public protocol DictModelProtocol{
    static func customClassMapping() -> [String: String]?
}

extension NSObject{
    //dict: 要进行转换的字典
    class func objectWithKeyValues(_ dict: NSDictionary)->AnyObject?{
        if HEFoundation.isClassFromFoundation(self) {
            print("只有自定义模型类才可以字典转模型")
            assert(true)
            return nil
        }
        
        let obj:AnyObject = self.init()
        var cls:AnyClass = self.classForCoder()                                           //当前类的类型
        
        while("NSObject" !=  "\(cls)"){
            var count:UInt32 = 0
            let properties =  class_copyPropertyList(cls, &count)                         //获取属性列表
            for i in 0..<count{
                let property = properties?[Int(i)]                                         //获取模型中的某一个属性
                let propertyType = String(cString: property_getAttributes(property))  //属性类型
                var propertyKey = String(cString: property_getName(property))         //属性名称
                if propertyKey == "desc"{//description是Foundation中的计算型属性，是实例的描述信息
                    propertyKey = "description"
                }
                var value = dict[propertyKey]      //取得字典中的值
                let dic = dict as! [String:AnyObject]
                let valueD = dic[propertyKey]
                let valueType = "\(valueD?.classForCoder)"
                if propertyKey == "description"{
                    propertyKey = "desc"
                }
                if valueType.contains("NSArray"){//数组
                    //值是数组。 数组中存放字典。 将字典转换成模型。 如果协议中没有定义映射关系，就不做处理
                    if self.responds(to: "customClassMapping") {
                        if var subModelClassName = cls.customClassMapping()?[propertyKey]{   //子模型的类名称
                            subModelClassName =  HEFoundation.bundlePath+"."+subModelClassName
                            if let subModelClass = NSClassFromString(subModelClassName){
                                if value != nil {
                                  value = subModelClass.objectArrayWithKeyValuesArray(value as! [AnyObject]);
                                }
                            }
                        }
                    }
                    obj.setValue(value, forKey: propertyKey)
                }else if valueType.contains("NSDictionary") {//字典
                    //1，值是字典。 这个字典要对应一个自定义的模型类并且这个类不是Foundation中定义的类型。
                    let subModelStr:String! = HEFoundation.getType(propertyType)
                    if subModelStr == nil{
                        print("你定义的模型与字典不匹配。 字典中的键\(propertyKey)  对应一个自定义的 模型")
                        assert(true)
                    }
                    if let subModelClass = NSClassFromString(subModelStr){
                        if value != nil {
                            value = subModelClass.objectWithKeyValues(value as! NSDictionary) //递归
                        }
                    }
                    obj.setValue(value, forKey: propertyKey)
                }else if valueType.contains("NSNull"){
                    obj.setValue(nil, forKey: propertyKey)
                }else{
                    if value != nil {
                        value = ""+"\(value!)"
                        obj.setValue(value, forKey: propertyKey)
                    }
                }
            }
            free(properties)                            //释放内存
            cls = cls.superclass()!                     //处理父类
        }
        return obj
    }
    

    
    /**
     将字典数组转换成模型数组
     array: 要转换的数组, 数组中包含的字典所对应的模型类就是 调用这个类方法的类
     
     当数组中嵌套数组， 内部的数组包含字典，cls就是内部数组中的字典对应的模型
     */
    class func objectArrayWithKeyValuesArray(_ array: [AnyObject])->[AnyObject]?{
        if array.count == 0{
            return nil
        }
        var result = [AnyObject]()
        for item in array{
            let type = "\(item.classForCoder)"
            if type.contains("NSDictionary"){
                if let model = objectWithKeyValues(item as! NSDictionary){
                    result.append(model)
                }
            }else if type.contains("NSArray"){
                if let model =  objectArrayWithKeyValuesArray(item as! [AnyObject]){
                    result.append(model as AnyObject)
                }
            }else{
                result.append(item)
            }
        }
        if result.count==0{
            return nil
        }else{
            return result
        }
    }
}
