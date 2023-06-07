//
//  CategoryButton.swift
//  Expenses
//
//  Created by Ума Мирзоева on 01/06/2023.
//

import Foundation
import UIKit

class CategoryButton: UIButton {
    private let buttonSize: CGFloat = 70.0
    private var category: categoryNames?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateImage(categoryNumber: Int) {
        switch categoryNumber {
        case 1: category = .Rent
        case 2: category = .Food
        case 3: category = .Transport
        case 4: category = .Clothes
        case 5: category = .Fun
        case 6: category = .Medicine
        default: break;
        }
        
        layer.borderWidth  = 3
        layer.cornerRadius = buttonSize/2
        
        backgroundColor    = Colors.shared.backgroundColor
        tintColor          = Colors.shared.categoryButtonColor
        layer.borderColor  = Colors.shared.categoryButtonColor.cgColor
        
        setImage(categoryImagines(category: category!), for: .normal)
    }
    
    func getCategory() -> String {
        return category?.description ?? ""
    }
    
    func completeButtonLayout() {
        layer.borderWidth  = 3
        layer.cornerRadius = buttonSize/2

        backgroundColor    = Colors.shared.backgroundColor
        tintColor          = Colors.shared.completeButtonColor
        layer.borderColor  = Colors.shared.completeButtonColor.cgColor
        
        setImage(categoryImagines(category: categoryNames.Complete), for: .normal)
        
        isHidden = true
    }
    
}
