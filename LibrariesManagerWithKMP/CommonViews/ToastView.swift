//
//  ToastView.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import Foundation
import UIKit

class ToastView: UIView{

    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let textStackView: UIStackView = {
        let textStackView = UIStackView(frame: .zero)
        textStackView.axis = .vertical
        textStackView.spacing = 2
        textStackView.alignment = .center
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        return textStackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .preferredFont(forTextStyle: .subheadline)
        textLabel.textColor = .systemBackground
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    private let detailTextLabel: UILabel = {
        let detailTextLabel = UILabel()
        detailTextLabel.textColor = .systemGray
        detailTextLabel.font = .preferredFont(forTextStyle: .footnote)
        detailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return detailTextLabel
    }()
     
    public var image: UIImage?{
        get{
            return imageView.image
        }
        set(newImage){
            imageView.image = newImage
            imageView.isHidden = (newImage == nil)
        }
    }
    
    public var title: String?{
        get{
            return textLabel.text
        }
        set(newText){
            textLabel.text = newText
        }
    }
    
    public var subtitle: String?{
        get{
            return detailTextLabel.text
        }
        set(newText){
            detailTextLabel.text = newText
            detailTextLabel.isHidden = (newText == nil)
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        customizeView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func customizeView(){
        addSubviewsToView()
        setConstraintsToSubviews()
    }

    private func addSubviewsToView(){
        textStackView.addArrangedSubview(textLabel)
        textStackView.addArrangedSubview(detailTextLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textStackView)
        addSubview(stackView)
        
        stackView.setCustomSpacing(-16, after: imageView)
    }
    
    func setConstraintsToSubviews(){
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    public func setContent(_ content: ToastViewContent) {
        image = content.image
        title = content.title
        subtitle = content.subtitle
    }
}
