//
//  EditorViewController.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 25/02/2024.
//

import UIKit
import SnapKit

final class EditorViewController: UIViewController {

    private var topBarViewController: TopBarViewController!
    private var collectionView: UICollectionView!
    
    private var blocks = [Block]()
    private var activeBlockId: String?
    
    private let fileName = "scene"
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopBar()
        setupCollectionView()
        loadInitialState()
    }
    
    // MARK: Setup
    
    private func setupTopBar() {
        topBarViewController = TopBarViewController()
        add(child: topBarViewController)
        topBarViewController.view.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        topBarViewController.delegate = self
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BlockCell.self, forCellWithReuseIdentifier: "BlockCell")
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topBarViewController.view.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: Actions
    
    private func loadInitialState() {
        loadBlocks()
        if blocks.isEmpty {
            createBlock()
        }
    }
    
    private func loadBlocks() {
        if let data = try? FileSystemManager.shared.getFileData(fileName: fileName, fileFormat: "json") {
            do {
                let blocks = try JSONDecoder().decode([Block].self, from: data)
                self.blocks = blocks
                print("\n[EDITOR] Blocks:\n\(blocks)")
            } catch {
                print(error)
            }
        } else {
            print("\n[EDITOR] Error")
        }
    }
    
    private func saveBlocks() {
        do {
            let data = try JSONEncoder().encode(blocks)
            if let url = try? FileSystemManager.shared.saveFile(fileName: fileName,
                                                                fileFormat: "json", data: data) {
                print("\n[EDITOR] File saved at:\(url.path)")
            } else {
                print("\n[EDITOR] Error")
            }
        } catch {
            print(error)
        }
    }
    
    private func createBlock() {
        let block = Block()
        blocks.append(block)
        collectionView.reloadData()
        saveBlocks()
    }
}

extension EditorViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blocks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlockCell", for: indexPath) as? BlockCell {
            cell.delegate = self
            cell.block = blocks[indexPath.row]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = BlockView.itemHeight
        let children = blocks[indexPath.row].children
        if children.count > 0 {
            height = height * CGFloat(children.count) + height
        }
        print(height)
        return CGSize(width: collectionView.frame.width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension EditorViewController: BlockCellDelegate {
    
    func onPressReturn() {
        createBlock()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let lastId = blocks.last?.id {
                let cell = collectionView.visibleCells.compactMap({ $0 as? BlockCell }).first(where: { $0.blockView.block.id == lastId })
                cell?.blockView.textView.becomeFirstResponder()
            }
        }
    }
    
    func setActiveBlock(id: String) {
        activeBlockId = id
    }
}

extension EditorViewController: TopBarViewControllerDelegate {
    
    func onToLeft() {
        print(activeBlockId)
    }
    
    func onToRight() {
        print(activeBlockId)
        
        if let activeBlockId = activeBlockId, let activeBlockIndex = blocks.firstIndex(where: { $0.id == activeBlockId }) {
            let previousBlockIndex = activeBlockIndex - 1
            var previousBlock = blocks[previousBlockIndex]
            let activeBlock = blocks[activeBlockIndex]
            
            guard !previousBlock.children.map({ $0.id }).contains(activeBlockId) else { return }
            
            previousBlock.children.append(activeBlock)
            blocks[previousBlockIndex] = previousBlock
            
            self.activeBlockId = nil
            blocks.remove(at: activeBlockIndex)
            
            collectionView.reloadData()
        }
        saveBlocks()
    }
}
