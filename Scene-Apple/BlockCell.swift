//
//  BlockCell.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 25/02/2024.
//

import UIKit

final class BlockCell: UICollectionViewCell {
    
    var blockView: BlockView!
    var childBlockView: BlockView?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func setupUI() {
        blockView = BlockView()
        addSubview(blockView)
        blockView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(BlockView.itemHeight)
        }
    }
}
