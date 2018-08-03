//
//	Users.swift
//
//	Create by Nada Gamal on 2/8/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Users : NSObject, NSCoding{

	var users : [User]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		users = [User]()
		if let usersArray = dictionary["Users"] as? [[String:Any]]{
			for dic in usersArray{
				let value = User(fromDictionary: dic)
				users.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if users != nil{
			var dictionaryElements = [[String:Any]]()
			for usersElement in users {
				dictionaryElements.append(usersElement.toDictionary())
			}
			dictionary["Users"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         users = aDecoder.decodeObject(forKey :"Users") as? [User]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if users != nil{
			aCoder.encode(users, forKey: "Users")
		}

	}

}