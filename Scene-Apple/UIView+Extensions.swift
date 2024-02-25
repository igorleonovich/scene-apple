//
//  UIView+Extensions.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 25/02/2024.
//

import UIKit

extension UIView {
    
    // MARK: SnapKit
    
    func snap(offset: Int? = 0) {
        snp.makeConstraints { make in
            if let offset = offset {
                make.top.equalTo(offset)
                make.leading.equalTo(offset)
                make.trailing.equalTo(-offset)
                make.bottom.equalTo(-offset)
            } else {
                make.edges.equalToSuperview()
            }
        }
    }
}
