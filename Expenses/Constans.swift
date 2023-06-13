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

internal enum L {
    internal enum Alert {
        internal static let success = "Data saved"
        internal static let failure = "Failed to load data"
        internal static let emptyAmountField = "Enter a amount"
        internal static let wrongAmountData = "Invalid expense amount"
    }
    
    internal enum TextFieldPlaceholders {
        internal static let amount = "Enter a amount"
    }
    
    internal enum Themes {
        internal static let classic = "Classic"
        internal static let day = "Day"
        internal static let night = "Night"
    }
    
    internal enum CoreData {
        internal static let Expenses = "Expenses"
        internal static let Transaction = "Transaction"
        internal static let date = "date"
    }
    
    internal static let error = "Error"
    internal static let warning = "Warning"
    internal static let cancel = "Cancel"
    internal static let close = "Close"
    internal static let ok = "Ок"
    internal static let renew = "Retry"
    internal static let edit = "Edit"
    internal static let change = "Change"
    internal static let save = "Save"
}
