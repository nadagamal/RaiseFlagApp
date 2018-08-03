//
//  ServiceManager.swift
//  RaiseFlag
//
//  Created by Nada Gamal Mohamed on 8/1/18.
//  Copyright © 2018 Nada. All rights reserved.
//

import UIKit
import Alamofire
class ServiceManager: NSObject {
    public func getUsers(status:Bool,compeletion: @escaping ([User]?, Error?) -> ()){
        URLCache.shared.removeAllCachedResponses()
        Alamofire.request(URL(string: "http://9d3ac9ab.ngrok.io/api/getAllJson/"+String(status))!, method:.get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: headers).responseJSON { response in
            if (response.error != nil){
                compeletion(nil,response.error!)
            }
            else if(response.response != nil){
                var users = [User]()
                if response.result.value is Array<Any>{
                let list=response.result.value as! Array<Any>
                if list.count>0{
                for dic in list{
                    let user=User.init(fromDictionary:dic as! [String : Any])
                    users.append(user)
                }
                }
                }
                compeletion(users,nil)

            }
        }
    }
    public var headers: HTTPHeaders {
        return ["Accept-Language":"ar-EG"]
    }
}
