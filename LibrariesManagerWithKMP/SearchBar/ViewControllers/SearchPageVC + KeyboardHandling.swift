//
//  SearchPageVC + KeyboardHandling.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
extension SearchPageVC{
    func setUpKeyboardHandling(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardIsHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardIsShown), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardIsHidden(notification: Notification){
        // When keyboard is hidden alter the content inset of scroll as below
        self.tableView.contentInset = .zero
        self.tableView.scrollIndicatorInsets = tableView.contentInset
    }
    
    @objc func keyboardIsShown(notification: Notification){
        // When keyboard is shown alter the content inset of scroll as below
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        // scrollview's bottom anchor would be at the position of totalViewHeight - keyboardFrameHeight
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        self.tableView.scrollIndicatorInsets = tableView.contentInset

        view.setNeedsLayout()
        UIView.animate(withDuration: 2){[unowned self] in
            self.view.layoutIfNeeded()
        }
    }
}
