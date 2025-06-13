//
//  StarRatingView.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
import KMPLibrariesManager

class StarRatingView: UIView {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var firstStar: UIImageView = {
        let firstStar = UIImageView()
        firstStar.image = UIImage(systemName: "star")
        firstStar.tintColor = .label
        firstStar.translatesAutoresizingMaskIntoConstraints = false
        return firstStar
    }()
    
    lazy var secondStar: UIImageView = {
        let secondStar = UIImageView()
        secondStar.image = UIImage(systemName: "star")
        secondStar.tintColor = .label
        secondStar.translatesAutoresizingMaskIntoConstraints = false
        return secondStar
    }()
    
    lazy var thirdStar: UIImageView = {
        let thirdStar = UIImageView()
        thirdStar.image = UIImage(systemName: "star")
        thirdStar.tintColor = .label
        thirdStar.translatesAutoresizingMaskIntoConstraints = false
        return thirdStar
    }()
    
    lazy var forthStar: UIImageView = {
        let forthStar = UIImageView()
        forthStar.image = UIImage(systemName: "star")
        forthStar.tintColor = .label
        forthStar.translatesAutoresizingMaskIntoConstraints = false
        return forthStar
    }()
    
    lazy var fifthStar: UIImageView = {
        let fifthStar = UIImageView()
        fifthStar.image = UIImage(systemName: "star")
        fifthStar.tintColor = .label
        fifthStar.translatesAutoresizingMaskIntoConstraints = false
        return fifthStar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        setUpView()
        addSubviews()
        setConstraints()
    }
    
    func setUpView(){
        backgroundColor = .clear
    }
    
    func addSubviews(){
        addSubview(stackView)
        
        stackView.addArrangedSubview(firstStar)
        stackView.addArrangedSubview(secondStar)
        stackView.addArrangedSubview(thirdStar)
        stackView.addArrangedSubview(forthStar)
        stackView.addArrangedSubview(fifthStar)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func configure(with bookReviews: [BookReview_]){
        let avgRating = calculateAvgRatings(from: bookReviews)
        customizeStars(with: avgRating)
    }
    
    func customizeStars(with rating: Double){
        switch rating{
        case 0.1..<1.0:
            firstStar.image = UIImage(systemName: "star.leadinghalf.fill")
            secondStar.image = UIImage(systemName: "star")
            thirdStar.image = UIImage(systemName: "star")
            forthStar.image = UIImage(systemName: "star")
            fifthStar.image = UIImage(systemName: "star")
        case 1.0:
            firstStar.image = UIImage(systemName: "star.fill")
            secondStar.image = UIImage(systemName: "star")
            thirdStar.image = UIImage(systemName: "star")
            forthStar.image = UIImage(systemName: "star")
            fifthStar.image = UIImage(systemName: "star")
        case 1.1..<2.0:
            firstStar.image = UIImage(systemName: "star.fill")
            secondStar.image = UIImage(systemName: "star.leadinghalf.fill")
            thirdStar.image = UIImage(systemName: "star")
            forthStar.image = UIImage(systemName: "star")
            fifthStar.image = UIImage(systemName: "star")
        case 2.0:
            firstStar.image = UIImage(systemName: "star.fill")
            secondStar.image = UIImage(systemName: "star.fill")
            thirdStar.image = UIImage(systemName: "star")
            forthStar.image = UIImage(systemName: "star")
            fifthStar.image = UIImage(systemName: "star")
            
        case 2.1..<3.0:
            firstStar.image = UIImage(systemName: "star.fill")
            secondStar.image = UIImage(systemName: "star.fill")
            thirdStar.image = UIImage(systemName: "star.leadinghalf.fill")
            forthStar.image = UIImage(systemName: "star")
            fifthStar.image = UIImage(systemName: "star")
            
        case 3.0:
            firstStar.image = UIImage(systemName: "star.fill")
            secondStar.image = UIImage(systemName: "star.fill")
            thirdStar.image = UIImage(systemName: "star.fill")
            forthStar.image = UIImage(systemName: "star")
            fifthStar.image = UIImage(systemName: "star")
            
        case 3.1..<4.0:
            firstStar.image = UIImage(systemName: "star.fill")
            secondStar.image = UIImage(systemName: "star.fill")
            thirdStar.image = UIImage(systemName: "star.fill")
            forthStar.image = UIImage(systemName: "star.leadinghalf.fill")
            fifthStar.image = UIImage(systemName: "star")
            
        case 4.0:
            firstStar.image = UIImage(systemName: "star.fill")
            secondStar.image = UIImage(systemName: "star.fill")
            thirdStar.image = UIImage(systemName: "star.fill")
            forthStar.image = UIImage(systemName: "star.fill")
            fifthStar.image = UIImage(systemName: "star")
            
        case 4.1..<5.0:
            firstStar.image = UIImage(systemName: "star.fill")
            secondStar.image = UIImage(systemName: "star.fill")
            thirdStar.image = UIImage(systemName: "star.fill")
            forthStar.image = UIImage(systemName: "star.fill")
            fifthStar.image = UIImage(systemName: "star.leadinghalf.fill")
            
        case 5.0:
            firstStar.image = UIImage(systemName: "star.fill")
            secondStar.image = UIImage(systemName: "star.fill")
            thirdStar.image = UIImage(systemName: "star.fill")
            forthStar.image = UIImage(systemName: "star.fill")
            fifthStar.image = UIImage(systemName: "star.fill")
            
        default:
            firstStar.image = UIImage(systemName: "star")
            secondStar.image = UIImage(systemName: "star")
            thirdStar.image = UIImage(systemName: "star")
            forthStar.image = UIImage(systemName: "star")
            fifthStar.image = UIImage(systemName: "star")
        }
    }
    
    func calculateAvgRatings(from bookReviews: [BookReview_]) -> Double{
        let totalNumOfReviews = Double(bookReviews.count)
        var sumOfRatings = 0.0
        
        bookReviews.forEach { review in
            sumOfRatings += Double(review.rating)
        }
        
        return sumOfRatings / totalNumOfReviews
    }
    
}


