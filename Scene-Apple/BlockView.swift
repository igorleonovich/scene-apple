//
//  BlockView.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 25/02/2024.
//

import UIKit

final class BlockView: UIView {
    
    static let itemHeight: CGFloat = 50
    
    weak var delegate: BlockViewDelegate?
    
    var textView: UITextView!
    
    var block: Block! {
        didSet {
            configure(with: block)
        }
    }
    
    // MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if let view = view, view == self {
            return textView
        }
        return view
    }
    
    // MARK: Setup
    
    private func setupUI() {
        textView = UITextView()
        addSubview(textView)
        textView.snap(offset: 10)
        textView.delegate = self
    }
    
    // MARK: Actions
    
    private func configure(with block: Block) {
        textView.text = block.text
    }
}

extension BlockView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            // Detected return key press
            print("Return key pressed")
            delegate?.onPressReturn()
            // Do any action you need here. For example:
            // textView.resignFirstResponder() // to hide the keyboard
            
            // Return false to prevent the new line character from being added to the text view
            return false
        }
        
        // Return true for all other cases to allow the text change
        return true
    }
}

protocol BlockViewDelegate: AnyObject {
    
    func onPressReturn()
}
