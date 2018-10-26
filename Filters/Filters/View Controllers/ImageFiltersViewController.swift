//
//  ImageFiltersViewController.swift
//  Filters
//
//  Created by Linh Bouniol on 10/25/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Cocoa

class ImageFiltersViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var inputImage: CIImage? = nil {
        didSet {
            reprocessImage()
        }
    }
    
    @IBOutlet weak var filtersTableView: NSTableView!
    @IBOutlet weak var slidersTableView: NSTableView!
    @IBOutlet weak var imageView: NSImageView!
    
    @IBAction func openDocument(_ sender: Any?) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false  // dont want to open a folder
        openPanel.canChooseFiles = true // can select files
        openPanel.allowedFileTypes = [kUTTypeImage as String] // can only choose images
    
        openPanel.beginSheetModal(for: self.view.window!) { (result) in
            guard result == .OK else { return }
            guard let imageURL = openPanel.url else { return }
            
            self.inputImage = CIImage(contentsOf: imageURL)
        }
    }
    
    @IBAction func saveDocument(_ sender: Any?) {
        let savePanel = NSSavePanel()
        savePanel.allowedFileTypes = [kUTTypeTIFF as String]
        savePanel.beginSheetModal(for: self.view.window!) { (result) in
            guard result == .OK else { return }
            guard let imageURL = savePanel.url else { return }
            guard let imageData = self.imageView.image?.tiffRepresentation else { return }
            
            try? imageData.write(to: imageURL, options: .atomic)
        }
    }
    
    @IBAction func updateImage(_ sender: Any?) {
        reprocessImage()
    }
    
    @objc dynamic var filters: [Filter] = [Filter(name: "CIColorControls", sliders: [Filter.Slider(name: "Brightness",
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
                                                                                     sliderDefault: 0)]),
                            Filter(name: "CIColorPosterize", sliders: [Filter.Slider(name: "Levels",
                                                                                   inputName: "inputLevels",
                                                                                   sliderMin: 0,
                                                                                   sliderMax: 12,
                                                                                   sliderDefault: 6)])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    // MARK: - NSTableViewDataSource for filter table view
    
//    func numberOfRows(in tableView: NSTableView) -> Int {
//        return filters.count
//    }
//    
//    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
//        return filters[row]
//    }
//    
//    // MARK: - NSTableViewDelegate
//    func tableViewSelectionDidChange(_ notification: Notification) {
//        let index = filtersTableView.selectedRow
//        guard index >= 0 else {
//            slidersTableView.dataSource = nil
//            return
//        }
//        
//        let filter = filters[index]
//        slidersTableView.dataSource = filter
//    }
    
    
    
    func reprocessImage() {
        
        // copy of the image is passed to the filter. the inputImage is still the original so when reprocessImage() gets called again, by the slider, another copy gets passed in.
        guard var filterInputImage = inputImage else { return }
        
        // inputImage here is the outputImage from the previous filtering process, this is only for the loop.
//        var outputImage = inputImage
        
        for filter in filters {
            guard let ciFilter = filter.filter else { continue } // continue to the next item in the loop if the filter is invalid
            
            // take previous outImage, pass it as the inputImage to the filter, after the filter does its thing, grab the filter's outputImage and save it for the next filter
            ciFilter.setValue(filterInputImage, forKey: kCIInputImageKey)
            
            filterInputImage = ciFilter.outputImage!
        }
        
        let imageRepresentation: NSCIImageRep = NSCIImageRep(ciImage: filterInputImage)
        let displayImage: NSImage = NSImage(size: imageRepresentation.size)
        displayImage.addRepresentation(imageRepresentation)
        imageView.image = displayImage
    }
}
