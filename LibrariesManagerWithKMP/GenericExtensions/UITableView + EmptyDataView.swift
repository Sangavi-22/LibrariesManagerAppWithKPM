//
//  UITableView + EmptyDataView.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
extension UITableView{
    func restore(){
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func setEmptyView(text: String, imageName: String){
        let emptyDataHandlingView = EmptyDataView()
        emptyDataHandlingView.setDataInSubviews(text: text, imageName: imageName)
        emptyDataHandlingView.frame = self.bounds
        
        self.backgroundView = emptyDataHandlingView
        self.separatorStyle = .none
    }
}
