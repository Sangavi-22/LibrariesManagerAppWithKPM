//
//  UILabel + AnimateLabelText.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 12/06/25.
//

import UIKit

extension UILabel {
    
    func animateLabelText(stringToAnimate: String, delay: TimeInterval){
        self.text = "\t"
        for (index, character) in stringToAnimate.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay * Double(index)) {
                self.text?.append(character)
            }
        }
    }
    
}
