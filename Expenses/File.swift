//
//  File.swift
//  Expenses
//
//  Created by Ума Мирзоева on 01/06/2023.
//

import UIKit


func categoryImagines(category: categoryNames) -> UIImage? {
    switch category {
    case .Rent: return UIImage(systemName: "house.fill") ?? nil
    case .Food: return UIImage(systemName: "cart.fill") ?? nil
    case .Clothes: return UIImage(systemName: "tshirt.fill") ?? nil
    case .Fun: return UIImage(systemName: "hands.sparkles.fill") ?? nil
    case .Medicine: return UIImage(systemName: "pills.fill") ?? nil
    case .Transport: return UIImage(systemName: "train.side.front.car") ?? nil
    case .Complete: return UIImage(systemName: "arrow.up") ?? nil
    }
}

enum categoryNames {
    case Rent, Food, Transport, Clothes, Fun, Medicine, Complete
    
    var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .Rent: return "Rent"
        case .Food: return "Food"
        case .Transport: return "Transport"
        case .Clothes: return "Clothes"
        case .Fun: return "Fun"
        case .Medicine: return "Medicine"
        case .Complete: return "Complete"
        }
      }
}
