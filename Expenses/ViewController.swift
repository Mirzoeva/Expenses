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
    var completeButton: UIButton?
    
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
                
        let openStatsButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(openStatsTapped))
        openStatsButton.tintColor = UIColor.blue
        navigationItem.rightBarButtonItem = openStatsButton
    }
    
    private func buttonsLayout() {
        let centerPoint = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 350)
        let radius: CGFloat = 100.0
        let buttonSize: CGFloat = 70.0
        let angleIncrement = CGFloat.pi / 3.0
        
        func categoryButtonsLayout() {
            for i in 1..<7 {
                var category = categoryNames.Fun
                switch i {
                case 1: category = categoryNames.Rent
                case 2: category = categoryNames.Food
                case 3: category = categoryNames.Transport
                case 4: category = categoryNames.Clothes
                case 5: category = categoryNames.Fun
                case 6: category = categoryNames.Medicine
                default: break;
                }
                
                let angle = angleIncrement * CGFloat(i)
                let x = centerPoint.x + radius * cos(angle)
                let y = centerPoint.y + radius * sin(angle)
                let button = UIButton(frame: CGRect(x: x - buttonSize/2, y: y - buttonSize/2, width: buttonSize, height: buttonSize))
                button.backgroundColor = UIColor.white
                button.tintColor = UIColor.blue
                button.layer.borderWidth = 3
                button.layer.borderColor = UIColor.blue.cgColor
                button.tag = i
                button.setImage(categoryImagines(category: category), for: .normal)
                button.layer.cornerRadius = buttonSize/2
                button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
                self.view.addSubview(button)
            }
        }
        
        func completeButtonLayout() {
            completeButton = UIButton(frame: CGRect(x: self.view.frame.width/2 - buttonSize/2, y: self.view.frame.height - 350 - buttonSize/2, width: buttonSize, height: buttonSize))
            completeButton?.backgroundColor = UIColor.white
            completeButton?.layer.borderWidth = 3
            completeButton?.tintColor = UIColor.systemPink
            completeButton?.layer.borderColor = UIColor.systemPink.cgColor
            completeButton?.setImage(categoryImagines(category: categoryNames.Complete), for: .normal)
            completeButton?.isHidden = true
            completeButton?.layer.cornerRadius = buttonSize/2
            completeButton?.addTarget(self, action: #selector(completeButtonTapped(_:)), for: .touchUpInside)
            self.view.addSubview(completeButton!)
        }
        
        categoryButtonsLayout()
        completeButtonLayout()
    }
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
        if let selectedButton = self.selectedButton {
            // если да, то сбрасываем ее состояние и изменяем цвет фона на исходный
            selectedButton.isSelected = false
            selectedButton.tintColor = UIColor.blue
        }
        
        
        completeButton?.isHidden = false
        // сохраняем ссылку на выбранную кнопку и изменяем ее цвет фона
        self.selectedButton = sender
        sender.isSelected = true
        sender.tintColor = UIColor.systemPink
    }
    
    @objc func completeButtonTapped(_ sender: UIButton) {
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
        
        var category = categoryNames.Fun
        switch sender.tag {
        case 1: category = categoryNames.Rent
        case 2: category = categoryNames.Food
        case 3: category = categoryNames.Transport
        case 4: category = categoryNames.Clothes
        case 5: category = categoryNames.Fun
        case 6: category = categoryNames.Medicine
        default: break;
        }
        
//        // удаление транзакции
//        let transactions = CoreDataHelper.shared.fetchTransactions()
//        for transaction in transactions {
//            CoreDataHelper.shared.deleteTransaction(transaction: transaction)
//        }
//        if let transaction = transactions.first {
//            CoreDataHelper.shared.deleteTransaction(transaction: transaction)
//        }
        
        // добавление новой транзакции
        CoreDataHelper.shared.saveTransaction(category: category.description, amount: expenseAmount)
        
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
        expenseTextField.layer.borderWidth = 1
        expenseTextField.layer.borderColor = UIColor.blue.cgColor
        
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

