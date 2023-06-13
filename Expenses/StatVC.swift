//
//  StatVC.swift
//  Expenses
//
//  Created by Ума Мирзоева on 13/06/2023.
//

import UIKit

class StatVC: UIViewController {
    
    var categoryView: CategoryStatView
    
    init() {
        self.categoryView = CategoryStatView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.shared.backgroundColor

        let barButtonMenu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Day statistics", comment: ""))
            { _ in
                self.categoryView.category = .Day
            },
            UIAction(title: NSLocalizedString("Month statistics", comment: ""))
            { _ in
                self.categoryView.category = .Month
            },
            UIAction(title: NSLocalizedString("Year statistics", comment: ""))
            { _ in
                self.categoryView.category = .Year
            }
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Manage", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.menu = barButtonMenu
        
        layout()
    }
    
    private func layout() {
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryView)
        
        NSLayoutConstraint.activate([
            categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
