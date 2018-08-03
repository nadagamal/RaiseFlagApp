//
//	User.swift
//
//	Create by Nada Gamal on 2/8/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class User : NSObject, NSCoding{

	var active : Bool!
	var fullName : String!
	var groupId : Int!
	var id : Int!
	var latitude : String!
	var longitude : String!
	var mobile : String!
	var notify : Bool!
	var outOfRange : Bool!
	var tracked : Bool!
    var hasReported : Bool!



	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		active = dictionary["active"] as? Bool
		fullName = dictionary["fullName"] as? String
		groupId = dictionary["groupId"] as? Int
		id = dictionary["id"] as? Int
		latitude = dictionary["latitude"] as? String
		longitude = dictionary["longitude"] as? String
		mobile = dictionary["mobile"] as? String
		notify = dictionary["notify"] as? Bool
		outOfRange = dictionary["outOfRange"] as? Bool
		tracked = dictionary["tracked"] as? Bool
        hasReported = dictionary["hasReported"] as? Bool

	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if active != nil{
			dictionary["active"] = active
		}
		if fullName != nil{
			dictionary["fullName"] = fullName
		}
		if groupId != nil{
			dictionary["groupId"] = groupId
		}
		if id != nil{
			dictionary["id"] = id
		}
		if latitude != nil{
			dictionary["latitude"] = latitude
		}
		if longitude != nil{
			dictionary["longitude"] = longitude
		}
		if mobile != nil{
			dictionary["mobile"] = mobile
		}
		if notify != nil{
			dictionary["notify"] = notify
		}
		if outOfRange != nil{
			dictionary["outOfRange"] = outOfRange
		}
		if tracked != nil{
			dictionary["tracked"] = tracked
		}
        if hasReported != nil{
            dictionary["hasReported"] = hasReported
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         active = aDecoder.decodeObject(forKey: "active") as? Bool
         fullName = aDecoder.decodeObject(forKey: "fullName") as? String
         groupId = aDecoder.decodeObject(forKey: "groupId") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         latitude = aDecoder.decodeObject(forKey: "latitude") as? String
         longitude = aDecoder.decodeObject(forKey: "longitude") as? String
         mobile = aDecoder.decodeObject(forKey: "mobile") as? String
         notify = aDecoder.decodeObject(forKey: "notify") as? Bool
         outOfRange = aDecoder.decodeObject(forKey: "outOfRange") as? Bool
         tracked = aDecoder.decodeObject(forKey: "tracked") as? Bool
       hasReported = aDecoder.decodeObject(forKey: "hasReported") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if active != nil{
			aCoder.encode(active, forKey: "active")
		}
		if fullName != nil{
			aCoder.encode(fullName, forKey: "fullName")
		}
		if groupId != nil{
			aCoder.encode(groupId, forKey: "groupId")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if latitude != nil{
			aCoder.encode(latitude, forKey: "latitude")
		}
		if longitude != nil{
			aCoder.encode(longitude, forKey: "longitude")
		}
		if mobile != nil{
			aCoder.encode(mobile, forKey: "mobile")
		}
		if notify != nil{
			aCoder.encode(notify, forKey: "notify")
		}
		if outOfRange != nil{
			aCoder.encode(outOfRange, forKey: "outOfRange")
		}
		if tracked != nil{
			aCoder.encode(tracked, forKey: "tracked")
		}
        if hasReported != nil{
            aCoder.encode(hasReported, forKey: "hasReported")
        }

	}

}
