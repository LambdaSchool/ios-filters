//
//  ImageFiltersViewController.swift
//  Filters
//
//  Created by Linh Bouniol on 10/25/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Cocoa

class ImageFiltersViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var filtersTableView: NSTableView!
    @IBOutlet weak var slidersTableView: NSTableView!
    @IBOutlet weak var imageView: NSImageView!
    
    var filters: [Filter] = [Filter(name: "CIColorControls", sliders: [Filter.Slider(name: "Brightness",
                                                                                     inputName: "inputBrightness",
                                                                                     sliderMin: -1,
                                                                                     sliderMax: 1,
                                                                                     sliderDefault: 0),
                                                                       Filter.Slider(name: "Contrast",
                                                                                     inputName: "inputContrast",
                                                                                     sliderMin: 0.25,
                                                                                     sliderMax: 4,
                                                                                     sliderDefault: 1),
                                                                       Filter.Slider(name: "Saturation",
                                                                                     inputName: "inputSaturation",
                                                                                     sliderMin: 0,
                                                                                     sliderMax: 3,
                                                                                     sliderDefault: 1)]),
                             Filter(name: "CIGaussianBlur", sliders: [Filter.Slider(name: "Radius",
                                                                                     inputName: "inputRadius",
                                                                                     sliderMin: 0,
                                                                                     sliderMax: 20,
                                                                                     sliderDefault: 0)])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return filters[row]
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let index = filtersTableView.selectedRow
        guard index >= 0 else {
            slidersTableView.dataSource = nil
            return
        }
        
        let filter = filters[index]
        slidersTableView.dataSource = filter
    }
}
