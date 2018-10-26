//
//  Input.swift
//  Filters
//
//  Created by Andrew Dhan on 10/25/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Cocoa

class Input: NSObject {

    init(filter: CIFilter, inputName name: String){
        self.name = name
        
        let dictionary = filter.attributes[name] as! [String: Any]
        self.value = dictionary["CIAttributeDefault"] as! Double
        self.max = dictionary["CIAttributeSliderMax"] as! Double
        self.min = dictionary["CIAttributeSliderMin"] as! Double
    }
    
    @objc let name:String
    @objc var value: Double
    @objc let max:Double
    @objc let min:Double
}
