//
//  TopBarViewController.swift
//  Scene-Apple
//
//  Created by Igor Leonovich on 25/02/2024.
//

import UIKit

final class TopBarViewController: UIViewController {
    
    weak var delegate: TopBarViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.snap()
        stackView.distribution = .fillEqually
        
        let toLeftButton = UIButton()
        toLeftButton.addTarget(self, action: #selector(onToLeft), for: .touchUpInside)
        toLeftButton.setTitle("To Left", for: .normal)
        stackView.addArrangedSubview(toLeftButton)
        
        let toRightButton = UIButton()
        toRightButton.addTarget(self, action: #selector(onToRight), for: .touchUpInside)
        toRightButton.setTitle("To Right", for: .normal)
        stackView.addArrangedSubview(toRightButton)
    }
    
    @objc private func onToLeft() {
        delegate?.onToLeft()
    }
    
    @objc private func onToRight() {
        delegate?.onToRight()
    }
}

protocol TopBarViewControllerDelegate: AnyObject {
    
    func onToLeft()
    func onToRight()
}
