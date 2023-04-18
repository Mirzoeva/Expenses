//
//  ViewController.swift
//  Expenses
//
//  Created by Ума Мирзоева on 22/03/2023.
//

import UIKit

class ViewController: UIViewController {
    let expenseTextField = UITextField()
    var isAmountEntered: Bool { return !expenseTextField.text!.isEmpty }
    
    var selectedButton: UIButton?
    
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
        let statsVC = UIViewController()
        statsVC.view.backgroundColor = .white
        navigationController?.pushViewController(statsVC, animated: true)
    }
    
    private func screenLayout() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
                
        let openStatsButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openStatsTapped))
        navigationItem.rightBarButtonItem = openStatsButton
    }
    
    private func buttonsLayout() {
        let centerPoint = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 250)
        let radius: CGFloat = 100.0
        let buttonSize: CGFloat = 70.0
        let angleIncrement = CGFloat.pi / 3.0
        
        for i in 1..<7 {
            let angle = angleIncrement * CGFloat(i)
            let x = centerPoint.x + radius * cos(angle)
            let y = centerPoint.y + radius * sin(angle)
            let button = UIButton(frame: CGRect(x: x - buttonSize/2, y: y - buttonSize/2, width: buttonSize, height: buttonSize))
            button.backgroundColor = UIColor.blue
            button.tag = i
            button.layer.cornerRadius = buttonSize/2
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            self.view.addSubview(button)
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let expenseText = expenseTextField.text, !expenseText.isEmpty else {
            // Если текстовое поле пустое, выход из метода
            return
        }
        
        // Преобразование текста введенной суммы в Double
        guard let expenseAmount = Double(expenseText) else {
            // Если текст нельзя преобразовать в число, выводим сообщение об ошибке
            print("Invalid expense amount")
            return
        }
        
        if let selectedButton = self.selectedButton {
            // если да, то сбрасываем ее состояние и изменяем цвет фона на исходный
            selectedButton.isSelected = false
            selectedButton.backgroundColor = UIColor.blue
        }
        // сохраняем ссылку на выбранную кнопку и изменяем ее цвет фона
        self.selectedButton = sender
        sender.isSelected = true
        sender.backgroundColor = UIColor.red
        
        
        var category = ""
        switch sender.tag {
        case 1: category = "Rent"
        case 2: category = "Food"
        case 3: category = "Transport"
        case 4: category = "Clothes"
        case 5: category = "Fun"
        case 6: category = "Medicine"
        default: break;
        }
        
        // удаление транзакции
        let transactions = CoreDataHelper.shared.fetchTransactions()
        for transaction in transactions {
            CoreDataHelper.shared.deleteTransaction(transaction: transaction)
        }
//        if let transaction = transactions.first {
//            CoreDataHelper.shared.deleteTransaction(transaction: transaction)
//        }
        
        // добавление новой транзакции
        CoreDataHelper.shared.saveTransaction(category: category, amount: expenseAmount)
        
        // чтение транзакций
        let newTransactions = CoreDataHelper.shared.fetchTransactions()
        for transaction in newTransactions {
            print("\(String(describing: transaction.category)): \(transaction.amount)")
        }
    }
    
    private func textFieldLayout() {
        view.addSubview(expenseTextField)
        expenseTextField.translatesAutoresizingMaskIntoConstraints = false
        expenseTextField.delegate = self
        
        expenseTextField.backgroundColor = .white
        expenseTextField.textColor = .black
        
        expenseTextField.layer.cornerRadius = 10
        expenseTextField.layer.borderWidth = 2
        expenseTextField.layer.borderColor = UIColor.systemGray4.cgColor
        
        expenseTextField.textAlignment = .center
        expenseTextField.font = UIFont.preferredFont(forTextStyle: .title2)
        expenseTextField.adjustsFontSizeToFitWidth = true
        expenseTextField.minimumFontSize = 12
        expenseTextField.placeholder = "Enter a amount"
        expenseTextField.keyboardType = .decimalPad
        
        NSLayoutConstraint.activate([
            expenseTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            expenseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            expenseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            expenseTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
}

extension ViewController: UITextFieldDelegate {
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

