//
//  CustomScrollView.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//
import UIKit

class CustomScrollView: UIScrollView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpScrollView(){
        self.backgroundColor = .systemBackground
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
