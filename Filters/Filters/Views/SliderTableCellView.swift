//
//  SliderTableCellView.swift
//  Filters
//
//  Created by Linh Bouniol on 10/25/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Cocoa

class SliderTableCellView: NSTableCellView {
    
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var slider: NSSlider!
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    // Dont need this class if we're using binding.
    
}
