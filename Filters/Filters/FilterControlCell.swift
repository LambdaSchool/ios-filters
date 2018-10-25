//
//  FilterControlCell.swift
//  Filters
//
//  Created by Andrew Dhan on 10/25/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Cocoa

class FilterControlCell: NSTableCellView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var slider: NSSlider!
}
