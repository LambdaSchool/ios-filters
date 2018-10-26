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
                self.imageView.image = NSImage(byReferencing: url)
            }
        }
    }
    
     @IBAction func saveDocumentAs(_ sender: Any?){

    }
    @IBAction func processImage(_ sender: NSSlider?){
        //sets input equal to the input being edited
        guard let sender = sender else {return}
        let inputRow = inputsTableView.row(for: sender)
        guard inputRow >= 0 else {return}
        let inputs = inputsController.arrangedObjects as! [Input]
        let input = inputs[inputRow]
        print(input.name, input.min, input.max, input.defaultValue, sender.doubleValue)
        
        //sets filter equal to the selected filter
        let filterIndex = filtersTableView.selectedRow
        guard filterIndex >= 0 else {return}
        let filters = filtersController.arrangedObjects as! [Filter]
        let filter = filters[filterIndex]
        
        //calls private property filter image
        imageView.image = filterImage(filter: filter, input: input, inputValue: sender.doubleValue)
        
        
    }
    //MARK: - Private Properties
    private func filterImage(filter: Filter, input: Input, inputValue: Double)-> NSImage?{
        guard let image = imageView.image,
        let ciImage = image.ciImage() else {return nil}
        let ciFilter = filter.filter
        ciFilter.setValue(ciImage, forKey: "inputImage")
        ciFilter.setValue(inputValue, forKey: input.name)
        
        guard let outputCIImage = ciFilter.outputImage,
            let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else {return nil}
        let outputSize = NSSize(width: outputCGImage.width, height: outputCGImage.height)
        return NSImage(cgImage: outputCGImage, size: outputSize)
        
    }

    //MARK: - Properties
    private let context = CIContext(options: nil)
    
    @IBOutlet weak var filtersTableView: NSTableView!
    @IBOutlet weak var inputsTableView: NSTableView!
    
    @IBOutlet weak var imageView: NSImageView!
    
    @IBOutlet var inputsController: NSArrayController!
    @IBOutlet var filtersController: NSArrayController!
    
    @objc let filters = [Filter(filterName: "CIColorControls"),
                         Filter(filterName: "CIGaussianBlur")]
}
