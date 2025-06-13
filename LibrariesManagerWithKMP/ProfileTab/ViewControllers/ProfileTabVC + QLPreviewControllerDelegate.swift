//
//  ProfileTabVC + QLPreviewControllerDelegate.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import QuickLook

extension ProfileTabVC: QLPreviewControllerDelegate, QLPreviewControllerDataSource{
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        imagePreviewItem.setData(image:  profilePicture.image ?? .add, title: "Profile pic preview")
        return imagePreviewItem as QLPreviewItem
    }
}
