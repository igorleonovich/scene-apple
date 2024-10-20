//
//  BlockView.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 25/02/2024.
//

import UIKit

final class BlockView: UIView {
    
    static let itemHeight: CGFloat = 70
    
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
        textView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-10)
        }
        textView.delegate = self
        textView.backgroundColor = .black
        textView.textColor = .white
        textView.font = .systemFont(ofSize: 26, weight: .regular)
    }
    
    // MARK: Actions
    
    private func configure(with block: Block) {
        textView.text = block.text
    }
}

extension BlockView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            print("Return key pressed")
            delegate?.onPressReturn()
            return false
        }
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        delegate?.setActiveBlock(id: block.id)
        return true
    }
}

protocol BlockViewDelegate: AnyObject {
    
    func onPressReturn()
    func setActiveBlock(id: String)
}
