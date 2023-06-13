//
//  AmountTextField.swift
//  Expenses
//
//  Created by Ума Мирзоева on 01/06/2023.
//

import Foundation
import UIKit

class AmountTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .white
        textColor       = .black
        
        layer.cornerRadius = 10
        layer.borderWidth  = 1
        layer.borderColor  = Colors.shared.categoryButtonColor.cgColor
        
        textAlignment      = .center
        font               = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize    = 12
        placeholder        = L.TextFieldPlaceholders.amount
        keyboardType       = .decimalPad
    }
    
}
