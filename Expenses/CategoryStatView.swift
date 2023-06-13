//
//  CategoryStatView.swift
//  Expenses
//
//  Created by Ума Мирзоева on 13/06/2023.
//

import UIKit

enum categoryStatNames: String {
    case Day, Month, Year
    
    var description : String {
        return self.rawValue
      }
}

class CategoryStatView: UIView {
    var category: categoryStatNames {
        didSet {
            switch category {
            case .Day: backgroundColor = .systemPink
            case .Month: backgroundColor = .systemBlue
            case .Year: backgroundColor = .systemMint
            }
        }
    }
    
    init() {
        self.category = .Month
        super.init(frame: .zero)
        self.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
