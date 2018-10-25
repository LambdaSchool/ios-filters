//
//  Filter.swift
//  Filters
//
//  Created by Andrew Dhan on 10/25/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Cocoa

class Filter: NSObject {
    init(filterName name: String) {
        guard let filter = CIFilter(name: name)else {
            fatalError("CIFilter cannot be initialized")
        }
        self.filter = filter
        
        var inputs = [Input]()
        let inputKeys = filter.inputKeys
        for inputKey in inputKeys{
            guard inputKey != "inputImage" else {continue}
            inputs.append(Input(filter: filter, inputName: inputKey))
        }
        self.inputs = inputs
    }
    var filter:CIFilter
    var inputs: [Input]
}
