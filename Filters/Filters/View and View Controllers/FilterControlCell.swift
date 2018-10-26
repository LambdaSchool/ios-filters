//
//  FilterControlCell.swift
//  Filters
//
//  Created by Andrew Dhan on 10/25/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Cocoa

class FilterControlCell: NSTableCellView {
    
    @IBAction func changeSliderValue(_ sender: NSSlider) {
        print(label.stringValue, slider.doubleValue)
        slider.didChangeValue(forKey: "SliderValue")
    }
    
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var slider: NSSlider!
}
