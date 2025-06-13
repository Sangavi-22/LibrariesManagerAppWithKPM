//
//  UIViewController + Toast.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import UIKit
extension UIViewController{
    
    func showToast(with content: ToastViewContent){
        
        let toast = createToast(with: content)
        self.view.addSubview(toast)
        
        let width = view.frame.width / 1.4
        toast.frame = CGRect(x: (view.frame.width - width) / 2, y: view.frame.height, width: width, height: 50)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                toast.frame = CGRect(x: (self.view.frame.width - width) / 2, y: self.view.frame.height - 160, width: width, height: 50)
            }, completion: { done in
                if done { self.dismiss(toast) }
            })
        }
        
    }
    
    func dismiss(_ toast: ToastView){
        let width = view.frame.width / 1.4
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                toast.frame = CGRect(x: (self.view.frame.width - width) / 2, y: self.view.frame.height - 160, width: width, height: 50)
            }, completion: { done in
                if done { toast.removeFromSuperview() }
            })
        })
    }
  
    func createToast(with content: ToastViewContent) -> ToastView{
        let toast = ToastView()
        toast.backgroundColor = .label
        toast.layer.cornerRadius = 20
        toast.setContent(content)
        return toast
    }
}


struct ToastViewContent{
    let image: UIImage?
    let title: String
    let subtitle: String?
    
    init(image: UIImage? = nil, title: String, subtitle: String? = nil) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
}
