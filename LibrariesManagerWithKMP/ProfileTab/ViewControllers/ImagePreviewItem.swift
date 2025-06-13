//
//  ImagePreviewItem.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import QuickLook

class ImagePreviewItem: NSObject, QLPreviewItem {
    
    var previewItemURL: URL?
    var previewItemTitle: String?
    
    func setData(image: UIImage, title: String){
        let imageData = image.pngData()
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(title).png")
        do {
            try imageData?.write(to: tempURL)
        } catch {
            print("Error writing image to temporary file: \(error.localizedDescription)")
        }
        self.previewItemURL = tempURL
        self.previewItemTitle = title
    }
}

