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
     @IBAction func openDocument(_ sender: Any?){
       
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        openPanel.begin { (response) in
            if response == NSApplication.ModalResponse.OK {
                let url = openPanel.urls.first!
                self.imageView.image = NSImage(byReferencing: url)
            }
        }

    
    }
    
     @IBAction func saveDocumentAs(_ sender: Any?){
    }
    //MARK: - Properties
    @IBOutlet weak var imageView: NSImageView!
}
