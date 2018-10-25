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
        self.max = dictionary["CIAttributeSliderMax"] as! NSNumber
        self.min = dictionary["CIAttributeSliderMin"] as! NSNumber
    }
    let name:String
    let max:NSNumber
    let min:NSNumber
}
