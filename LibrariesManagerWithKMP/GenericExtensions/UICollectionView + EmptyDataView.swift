//
//  UICollectionView + EmptyDataView.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//
import UIKit

extension UICollectionView{
    func restore(){
        self.backgroundView = nil
    }
    
    func setEmptyView(text: String, imageName: String){
        let emptyDataHandlingView = EmptyDataView()
        emptyDataHandlingView.setDataInSubviews(text: text, imageName: imageName)
        emptyDataHandlingView.frame = self.bounds
        
        self.backgroundView = emptyDataHandlingView
    }
}

