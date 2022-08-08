//
//  ViewController.swift
//  LoginValidation
//
//  Created by Андрей Колесников on 08.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {
    
    private let viewModel = SignInViewModel()
    private let bag = DisposeBag()
    
    private let helloLabel: UILabel = {
        let lb = UILabel()
        lb.text = "MyApp"
        lb.font = UIFont(name: "ArialHebrew", size: 18)
        return lb
    }()
    
    private let loginTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Login"
        tf.textColor = .gray
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 5.0
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        tf.leftViewMode = .always
        tf.layer.borderColor = UIColor.gray.cgColor
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.textColor = .gray
        tf.isSecureTextEntry = true
        tf.layer.borderWidth = 1.0
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        tf.leftViewMode = .always
        tf.layer.cornerRadius = 5.0
        tf.layer.borderColor = UIColor.gray.cgColor

        return tf
    }()
    
    private let loginButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .red
        bt.setTitle("Login", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.layer.cornerRadius = 5.0
        return bt
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        loginTextField.rx.text.map {$0 ?? ""}.bind(to: viewModel.loginTextFieldBehaviorSubject).disposed(by: bag)
        passwordTextField.rx.text.map {$0 ?? ""}.bind(to: viewModel.passwordTextFieldBehaviorSubject).disposed(by: bag)

        viewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: bag)
        viewModel.isValid().map{ $0 ? 1: 0.1 }.bind(to: loginButton.rx.alpha).disposed(by: bag)
        
        addConstraits()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func addConstraits() {
        view.addSubview(helloLabel)
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 15),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalToConstant: 240),
            loginTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 240),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 240),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


}

