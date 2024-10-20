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
    private var childrenStackView: UIStackView!
    
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
        backgroundColor = .darkGray
        setupBlock()
        setupChildrenBlocks()
    }
    
    private func setupBlock() {
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
    
    private func setupChildrenBlocks() {
        childrenStackView = UIStackView()
        addSubview(childrenStackView)
        childrenStackView.snp.makeConstraints { make in
            make.top.equalTo(blockView.snp.bottom)
            make.leading.equalTo(50)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        childrenStackView.axis = .vertical
    }
    
    // MARK: Actions
    
    private func configure(with block: Block) {
        blockView.block = block
        childrenStackView.removeArrangedSubviews()
        block.children.forEach { childBlock in
            let childBlockView = BlockView()
            childBlockView.block = childBlock
            childrenStackView.addArrangedSubview(childBlockView)
        }
    }
}

extension BlockCell: BlockViewDelegate {
    
    func onPressReturn() {
        delegate?.onPressReturn()
    }
    
    func setActiveBlock(id: String) {
        delegate?.setActiveBlock(id: id)
    }
}


protocol BlockCellDelegate: AnyObject {
    
    func onPressReturn()
    func setActiveBlock(id: String)
}
