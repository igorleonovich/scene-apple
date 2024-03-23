//
//  UIViewController+Extensions.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 25/02/2024.
//

import UIKit

extension UIViewController {
    
    // MARK: Childs
    
    func add(child: UIViewController, containerView: UIView? = nil) {
        addChild(child)
        if let containerView = containerView {
            containerView.addSubview(child.view)
        } else {
            view.addSubview(child.view)
        }
        child.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
