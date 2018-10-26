//
//  FilterViewController.swift
//  Filters
//
//  Created by Andrew Dhan on 10/25/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Cocoa

class FilterViewController: NSViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filtersTableView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
        
        
    }
    @IBAction func openDocument(_ sender: Any?){
        
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        openPanel.begin { (response) in
            if response == NSApplication.ModalResponse.OK {
                let url = openPanel.urls.first!
                self.originalImage = NSImage(byReferencing: url)
                self.imageView.image = self.originalImage
            }
        }
    }
    
    @IBAction func saveDocumentAs(_ sender: Any?){

        
    }
    
    //can add functionality to make program faster by creating array of filters with values changed from default
    //this would prevent the filteringImage to go through all the arrays just for one filter
    @IBAction func updateImage(_ sender: NSSlider?){
            imageView.image = filterImage()
    }
    //MARK: - Private Properties

    private func filterImage() -> NSImage?{
       //convert NSImage to CIImage for filtering
        guard let image = originalImage,
            var inputImage = image.ciImage() else {return nil}
        
        //go through filters and apply them
        let filters = filtersController.arrangedObjects as! [Filter]
        for filter in filters{
            let ciFilter = filter.filter
            let inputs = filter.inputs
            ciFilter.setValue(inputImage, forKey: "inputImage")
            for input in inputs{
                ciFilter.setValue(input.value, forKey: input.name)
            }
            inputImage = ciFilter.outputImage!
        }
        
        //convert CIImage to NSImage
        let outputCIImage = inputImage
        guard     let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else {return nil}
        let outputSize = NSSize(width: outputCGImage.width, height: outputCGImage.height)
        return NSImage(cgImage: outputCGImage, size: outputSize)
    }
    
    //MARK: - Properties
    private let context = CIContext(options: nil)
    
    private var originalImage: NSImage!
    
    @IBOutlet weak var filtersTableView: NSTableView!
    @IBOutlet weak var inputsTableView: NSTableView!
    
    @IBOutlet weak var imageView: NSImageView!
    
    @IBOutlet var inputsController: NSArrayController!
    @IBOutlet var filtersController: NSArrayController!
    
    @objc let filters = [Filter(filterName: "CIGaussianBlur"),
                         Filter(filterName: "CIColorControls")]
}
