//
//  BlockView.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 25/02/2024.
//

import UIKit

final class BlockView: UIView {
    
    static let itemHeight: CGFloat = 50
    
    var textView: UITextView!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if let view = view, view == self {
            return textView
        }
        return view
    }
    
    private func setupUI() {
        textView = UITextView()
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(10)
        }
        textView.delegate = self
    }
}

extension BlockView: UITextViewDelegate {
    
}
