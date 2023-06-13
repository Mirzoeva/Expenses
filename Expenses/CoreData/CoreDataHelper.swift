//
//  CoreDataHelper.swift
//  Expenses
//
//  Created by Ума Мирзоева on 18/04/2023.
//

import Foundation
import UIKit
import CoreData

protocol CoreData {
    var context: NSManagedObjectContext { get }
    func saveTransaction(category: String, amount: Double)
    func deleteTransaction(transaction: Transaction)
    func fetchTransactions() -> [Transaction]
}

final class CoreDataHelper: CoreData {
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: L.CoreData.Expenses)
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError(error.localizedDescription)
            } else {
                print(storeDescription)
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }

    static let shared = CoreDataHelper()
    
    
    func saveTransaction(category: String, amount: Double) {
        let transaction = Transaction(context: context)
        transaction.category = category
        transaction.amount = amount
        transaction.date = Date()
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteTransaction(transaction: Transaction) {
        context.delete(transaction)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func fetchTransactions() -> [Transaction] {
        let fetchRequest = NSFetchRequest<Transaction>(entityName: L.CoreData.Transaction)
        let sortDescriptor = NSSortDescriptor(key: L.CoreData.date, ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let transactions = try context.fetch(fetchRequest)
            return transactions
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
}
