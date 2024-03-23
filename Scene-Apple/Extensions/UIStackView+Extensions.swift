//
//  UIStackView+Extensions.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 27/02/2024.
//

import UIKit

extension UIStackView {
    
    func removeArrangedSubviews() {
        guard !arrangedSubviews.isEmpty else { return }
        let subviewsToRemove = arrangedSubviews.reduce([]) { allSubviews, subview -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        subviewsToRemove.forEach { subview in
            subview.snp.removeConstraints()
            subview.removeFromSuperview()
        }
    }
}
