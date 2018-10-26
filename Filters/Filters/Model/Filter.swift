//
//  Filter.swift
//  Filters
//
//  Created by Linh Bouniol on 10/25/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Cocoa

class Filter: NSObject {//, NSTableViewDataSource {    // if want to use binding, model must be class of tyoe NSObject
    
    init(name: String, sliders: [Slider]) {
        
        self.name = name
        self.sliders = sliders
        
        super.init()    // call when subclass NSObject
    }
    
    @objc dynamic var name: String
    @objc dynamic var sliders: [Slider]
    
    var filter: CIFilter? { // build up a CIFilter using the sliders
        
        var parameters: [String : Any] = [:]

        for slider in sliders {
            parameters[slider.inputName] = slider.sliderValue
        }
        
        return CIFilter(name: name, parameters: parameters)
    }
    
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
    
    // MARK: - NSTableViewDataSource for slider table view
    
//    func numberOfRows(in tableView: NSTableView) -> Int {
//        return sliders.count
//    }
//
//    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
//        return sliders[row]
//    }
    
    // Basically, the issue is that if you have the same controller be a data source for two table views, it gets complicated as to which table view should get the data.
    // So we avoid that problem by making the filters be the data source for the slider table view.
    
}
