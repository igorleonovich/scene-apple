//
//  EditorViewController.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 25/02/2024.
//

import UIKit
import SnapKit

final class EditorViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var blocks = [Block]()
    
    private let fileName = "scene"
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadInitialState()
    }
    
    // MARK: Setup

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BlockCell.self, forCellWithReuseIdentifier: "BlockCell")
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.snap()
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
        let block = Block(id: UUID().uuidString, text: "Your text", childrenIds: nil)
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
        return CGSize(width: collectionView.frame.width, height: BlockView.itemHeight)
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
}
