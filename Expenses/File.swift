//
//  File.swift
//  Expenses
//
//  Created by Ума Мирзоева on 01/06/2023.
//

import UIKit

public class Colors {
    static let shared = Colors()
    public let categoryButtonColor = UIColor.blue
    public let completeButtonColor = UIColor.systemPink
    public let backgroundColor = UIColor.white
}


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

enum categoryNames: String {
    case Rent, Food, Transport, Clothes, Fun, Medicine, Complete
    
    var description : String {
        return self.rawValue
      }
}
