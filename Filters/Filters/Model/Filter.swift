//
//  Filter.swift
//  Filters
//
//  Created by Linh Bouniol on 10/25/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Cocoa

class Filter: NSObject, NSTableViewDataSource {    // if want to use binding, model must be class of tyoe NSObject
    
    init(name: String, sliders: [Slider]) {
        
        self.name = name
        self.sliders = sliders
        
        super.init()    // call when subclass NSObject
    }
    
    @objc dynamic var name: String
    
//    var filter: CIFilter {
//        return CIFilter(name: name, parameters: <#T##[String : Any]?#>)
//    }
    @objc dynamic var sliders: [Slider]
    
    class Slider: NSObject {
        
        @objc dynamic var name: String  // show to user
        @objc dynamic var inputName: String // pass to filters
        @objc dynamic var sliderMin: Double
        @objc dynamic var sliderMax: Double
        @objc dynamic var sliderDefault: Double
        @objc dynamic var sliderValue: Double // current slider value
        
        init(name: String, inputName: String, sliderMin: Double, sliderMax: Double, sliderDefault: Double) {
            
            self.name = name
            self.inputName = inputName
            self.sliderMin = sliderMin
            self.sliderMax = sliderMax
            self.sliderDefault = sliderDefault
            self.sliderValue = sliderDefault
            
            super.init()
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return sliders.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return sliders[row]
    }
    
}
