//
//  BaseView.swift
//  
//
//  Created by Bradley Hoang on 29/12/2022.
//

import UIKit

class BaseView: UIView {
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
        awakeFromNib()
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
        configureView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupNib()
    }
    
    init() {
        super.init(frame: .zero)
        setupNib()
        configureView()
    }
}

// MARK: - Private

private extension BaseView {
    
    func setupNib() {
        backgroundColor = .clear
        let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: Bundle(for: type(of: self)))
        let topLevelViews = nib.instantiate(withOwner: self, options: nil)
        let nibView = topLevelViews.first as! UIView
        insertSubview(nibView, at: 0)
        
        nibView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nibView.leftAnchor.constraint(equalTo: leftAnchor),
            nibView.rightAnchor.constraint(equalTo: rightAnchor),
            nibView.topAnchor.constraint(equalTo: topAnchor),
            nibView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension BaseView {
    @objc func configureView() {}
}
