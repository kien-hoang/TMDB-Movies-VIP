//
//  CommonTextField.swift
//  teko
//
//  Created by Bradley Hoang on 29/12/2022.
//

import UIKit

final class CommonTextField: BaseView {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var inputContainerView: UIView!
    @IBOutlet private weak var rightImageView: UIImageView!
    @IBOutlet weak var inputTextField: UITextField!
    
    // MARK: - Public Variable
    
    var title: String? {
        didSet {
            titleLabel.isHidden = title == nil
            titleLabel.text = title
        }
    }
    
    var error: String? {
        didSet {
            errorLabel.isHidden = error == nil
            errorLabel.text = error
            inputContainerView.borderColor = error == nil ? UIColor.color_e6e6e6 : UIColor.color_f25d4e
        }
    }
    
    var rightImage: UIImage? {
        didSet {
            rightImageView.isHidden = rightImage == nil
            rightImageView.image = rightImage
        }
    }
    
    var isEditable: Bool = true {
        didSet {
            inputTextField.isEnabled = isEditable
            inputContainerView.backgroundColor = isEditable ? UIColor.color_ffffff : UIColor.color_e6e6e6_50
        }
    }
}
