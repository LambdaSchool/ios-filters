//
//  FilterViewController.swift
//  Filters
//
//  Created by Andrew Dhan on 10/25/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Cocoa

class FilterViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let filter = Filter(filterName: "CIGaussianBlur")
        for input in filter.inputs{
            print(input.name, input.max, input.min)
        }
    }
    
    @IBOutlet weak var imageView: NSImageView!
}
