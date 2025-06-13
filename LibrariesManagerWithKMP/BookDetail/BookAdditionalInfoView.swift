//
//  BookAdditionalInfoView.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//


import UIKit
import KMPLibrariesManager

class BookAdditionalInfoView: UIView{
    
    let bookIdView = ViewWithTitleAndContentFields()
    let libraryNameView = ViewWithTitleAndContentFields()
    let costView = ViewWithTitleAndContentFields()
    let publishedDateView = ViewWithTitleAndContentFields()
    let pagesCountView = ViewWithTitleAndContentFields()
    let languageView = ViewWithTitleAndContentFields()
    
    var potraitConstraints: [NSLayoutConstraint]!
    var landscapeConstraints: [NSLayoutConstraint]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkDeviceOrientation()
    }
    
    func setUpView(){
        addSubviewsToView()
        setConstraintsToSubviews()
        checkDeviceOrientation()
    }
    
    func addSubviewsToView(){
        self.addSubview(bookIdView)
        self.addSubview(libraryNameView)
        self.addSubview(costView)
        self.addSubview(languageView)
        self.addSubview(publishedDateView)
        self.addSubview(pagesCountView)
    }
    
    func setConstraintsToSubviews(){
        
        potraitConstraints = [
            bookIdView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            bookIdView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            bookIdView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            bookIdView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            libraryNameView.topAnchor.constraint(equalTo: bookIdView.bottomAnchor),
            libraryNameView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            libraryNameView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            libraryNameView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            costView.topAnchor.constraint(equalTo: libraryNameView.bottomAnchor),
            costView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            costView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            costView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            languageView.topAnchor.constraint(equalTo: costView.bottomAnchor),
            languageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            languageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            languageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            publishedDateView.topAnchor.constraint(equalTo: languageView.bottomAnchor),
            publishedDateView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            publishedDateView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            publishedDateView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            pagesCountView.topAnchor.constraint(equalTo: publishedDateView.bottomAnchor),
            pagesCountView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            pagesCountView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            pagesCountView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ]
        
        landscapeConstraints = [
            bookIdView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            bookIdView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bookIdView.widthAnchor.constraint(equalToConstant: 200),
            bookIdView.heightAnchor.constraint(equalToConstant: 44),
             
            libraryNameView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            libraryNameView.leadingAnchor.constraint(equalTo: bookIdView.trailingAnchor, constant: 40),
            libraryNameView.widthAnchor.constraint(equalToConstant: 240),
            libraryNameView.heightAnchor.constraint(equalToConstant: 44),
            
            costView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            costView.leadingAnchor.constraint(equalTo: libraryNameView.trailingAnchor, constant: 45),
            costView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            costView.heightAnchor.constraint(equalToConstant: 44),
            
            languageView.topAnchor.constraint(equalTo: bookIdView.bottomAnchor),
            languageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            languageView.widthAnchor.constraint(equalToConstant: 200),
            languageView.heightAnchor.constraint(equalToConstant: 44),
            
            publishedDateView.topAnchor.constraint(equalTo: libraryNameView.bottomAnchor),
            publishedDateView.leadingAnchor.constraint(equalTo: languageView.trailingAnchor, constant: 40),
            publishedDateView.widthAnchor.constraint(equalToConstant: 240),
            publishedDateView.heightAnchor.constraint(equalToConstant: 44),
            
            pagesCountView.topAnchor.constraint(equalTo: costView.bottomAnchor),
            pagesCountView.leadingAnchor.constraint(equalTo: publishedDateView.trailingAnchor, constant: 45),
            pagesCountView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            pagesCountView.heightAnchor.constraint(equalToConstant: 44)
        ]
    }
    
    func checkDeviceOrientation(){
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        let currentOrientation = windowScene.interfaceOrientation
        if currentOrientation.isPortrait {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(potraitConstraints)
            
        }
        else if currentOrientation.isLandscape {
            NSLayoutConstraint.deactivate(potraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
            
        }
    }
    
    func configure(with book: Book_, and libraryName: String){
        bookIdView.configure(with: "book", and: "Book ID", also: (book.id).isEmpty ? "-": book.id)
        
        libraryNameView.configure(with: "books.vertical", and: "Library", also: (book.genre).isEmpty ? "-": libraryName)
        
        costView.configure(with: "indianrupeesign.circle", and: "Cost", also: "\(book.cost)")
        
        languageView.configure(with: "character.book.closed", and: "Language", also: book.language)
        
        publishedDateView.configure(with: "calendar", and: "Published", also: book.publishedDate)
        
        pagesCountView.configure(with: "book.closed", and: "Pages", also: "\(book.pagesCount)")
    }
}
