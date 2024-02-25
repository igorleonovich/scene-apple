//
//  BlockCell.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 25/02/2024.
//

import UIKit

final class BlockCell: UICollectionViewCell {
    
    weak var delegate: BlockCellDelegate?
    
    var blockView: BlockView!
    private var childBlockView: BlockView?
    
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
    
    // MARK: Setup
    
    private func setupUI() {
        backgroundColor = .lightGray
        
        blockView = BlockView()
        addSubview(blockView)
        blockView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(BlockView.itemHeight)
        }
        blockView.delegate = self
    }
    
    // MARK: Actions
    
    private func configure(with block: Block) {
        blockView.block = block
    }
}

extension BlockCell: BlockViewDelegate {
    
    func onPressReturn() {
        delegate?.onPressReturn()
    }
}


protocol BlockCellDelegate: AnyObject {
    
    func onPressReturn()
}
