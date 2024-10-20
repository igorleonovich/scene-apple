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
        
        let toTheLeftButton = MoveBlockButton()
        toTheLeftButton.addTarget(self, action: #selector(onToTheLeft), for: .touchUpInside)
        toTheLeftButton.setTitle("To The Left", for: .normal)
        stackView.addArrangedSubview(toTheLeftButton)
        
        let toTheRightButton = MoveBlockButton()
        toTheRightButton.addTarget(self, action: #selector(onToTheRight), for: .touchUpInside)
        toTheRightButton.setTitle("To The Right", for: .normal)
        stackView.addArrangedSubview(toTheRightButton)
    }
    
    @objc private func onToTheLeft() {
        delegate?.onToTheLeft()
    }
    
    @objc private func onToTheRight() {
        delegate?.onToTheRight()
    }
}

protocol TopBarViewControllerDelegate: AnyObject {
    
    func onToTheLeft()
    func onToTheRight()
}

final class MoveBlockButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setTitleColor(.black, for: .normal)
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
