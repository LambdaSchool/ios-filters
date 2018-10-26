//
//  Image Extensions.swift
//  Filters
//
//  Created by Andrew Dhan on 10/26/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Cocoa

extension NSImage{
    func ciImage() -> CIImage?{
        guard let tiffData = self.tiffRepresentation,
        let bitmap = NSBitmapImageRep(data: tiffData) else {return nil}
        
        return CIImage(bitmapImageRep: bitmap)
    }
}
