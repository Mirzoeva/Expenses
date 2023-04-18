//
//  ViewController.swift
//  Expenses
//
//  Created by Ума Мирзоева on 22/03/2023.
//

import UIKit

class ViewController: UIViewController {
    let amountTextField = UITextField()
    var isAmountEntered: Bool { return !amountTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
                
        let openStatsButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openStatsTapped))
        navigationItem.rightBarButtonItem = openStatsButton

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
    
    private func textFieldLayout() {
        view.addSubview(amountTextField)
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        amountTextField.delegate = self
        
        amountTextField.backgroundColor = .white
        amountTextField.textColor = .black
        
        amountTextField.layer.cornerRadius = 10
        amountTextField.layer.borderWidth = 2
        amountTextField.layer.borderColor = UIColor.systemGray4.cgColor
        
        amountTextField.textAlignment = .center
        amountTextField.font = UIFont.preferredFont(forTextStyle: .title2)
        amountTextField.adjustsFontSizeToFitWidth = true
        amountTextField.minimumFontSize = 12
        amountTextField.placeholder = "Enter a amount"
        amountTextField.keyboardType = .decimalPad
        
        NSLayoutConstraint.activate([
            amountTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            amountTextField.heightAnchor.constraint(equalToConstant: 50)
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

