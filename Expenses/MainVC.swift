//
//  ViewController.swift
//  Expenses
//
//  Created by Ума Мирзоева on 22/03/2023.
//

import UIKit

class MainVC: UIViewController {
    let expenseTextField = AmountTextField()
    var isAmountEntered: Bool { return !expenseTextField.text!.isEmpty }
    
    var selectedButton: CategoryButton?
    var completeButton: CategoryButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenLayout()
        buttonsLayout()
        textFieldLayout()
    }
    
    @objc func openStatsTapped() {
        pushStatsVC()
    }
    
    @objc func pushStatsVC() {
        let statsVC = StatVC()
        navigationController?.pushViewController(statsVC, animated: true)
    }
    
    private func screenLayout() {
        view.backgroundColor = Colors.shared.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
                
        let openStatsButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(openStatsTapped))
        navigationItem.rightBarButtonItem = openStatsButton
    }
    
    private func buttonsLayout() {
        let centerPoint         = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 350)
        let radius: CGFloat     = 100.0
        let buttonSize: CGFloat = 70.0
        let angleIncrement      = CGFloat.pi / 3.0
        
        func categoryButtonsLayout() {
            for i in 1..<7 {
                let angle  = angleIncrement * CGFloat(i)
                let x      = centerPoint.x + radius * cos(angle)
                let y      = centerPoint.y + radius * sin(angle)
                let button = CategoryButton(frame: CGRect(x: x - buttonSize/2,
                                                          y: y - buttonSize/2,
                                                          width: buttonSize, height: buttonSize))
                button.updateImage(categoryNumber: i)
                button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
                self.view.addSubview(button)
            }
        }
        
        func completeButtonLayout() {
            completeButton = CategoryButton(frame: CGRect(x: self.view.frame.width/2 - buttonSize/2,
                                                          y: self.view.frame.height - 350 - buttonSize/2,
                                                          width: buttonSize, height: buttonSize))
            completeButton?.completeButtonLayout()
            completeButton?.addTarget(self, action: #selector(completeButtonTapped(_:)), for: .touchUpInside)
            self.view.addSubview(completeButton!)
        }
        
        categoryButtonsLayout()
        completeButtonLayout()
    }
    
    @objc func categoryButtonTapped(_ sender: CategoryButton) {
        if let selectedButton = self.selectedButton {
            // если да, то сбрасываем ее состояние и изменяем цвет фона на исходный
            selectedButton.isSelected = false
            selectedButton.tintColor  = Colors.shared.categoryButtonColor
        }
        
        completeButton?.isHidden = false
        // сохраняем ссылку на выбранную кнопку и изменяем ее цвет фона
        self.selectedButton = sender
        sender.isSelected = true
        sender.tintColor = Colors.shared.completeButtonColor
    }
    
    @objc func completeButtonTapped(_ sender: CategoryButton) {
        guard let expenseText = expenseTextField.text, !expenseText.isEmpty,
              let selectedButton = selectedButton else {
            Alert.show(L.Alert.emptyAmountField)
//            alertView(L.Alert.emptyAmountField)
            return
        }
        
        guard let expenseAmount = Double(expenseText) else {
            alertView(L.Alert.wrongAmountData)
            return
        }
        
        // удаление транзакции
        let transactions = CoreDataHelper.shared.fetchTransactions()
        for transaction in transactions {
            CoreDataHelper.shared.deleteTransaction(transaction: transaction)
        }
        if let transaction = transactions.first {
            CoreDataHelper.shared.deleteTransaction(transaction: transaction)
        }
        
        // добавление новой транзакции
        CoreDataHelper.shared.saveTransaction(category: selectedButton.getCategory(), amount: expenseAmount)
        
        // чтение транзакций
        let newTransactions = CoreDataHelper.shared.fetchTransactions()
        for transaction in newTransactions {
            print("\(String(describing: transaction.category)): \(transaction.amount)")
        }
        
        selectedButton.isSelected = false
        selectedButton.tintColor  = Colors.shared.categoryButtonColor
        completeButton?.isHidden = true
        if let amount = expenseTextField.text {
                NotificationBanner.show("Expense \(amount)$ for \(selectedButton.getCategory()) added")
        }
        expenseTextField.text = ""
    }
    
    private func textFieldLayout() {
        view.addSubview(expenseTextField)
        expenseTextField.delegate = self
        
        NSLayoutConstraint.activate([
            expenseTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            expenseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            expenseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            expenseTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func alertView(_ text: String) {
        let alert = UIAlertController(
            title: text,
            message: nil,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension MainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        pushFollowerListVC()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

