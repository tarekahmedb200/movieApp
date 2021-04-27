//
//  LoginViewController.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    private var viewModel = LoginViewModel()
    private var disposeBag = DisposeBag()
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var EnterAsGuestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservers()
        setupTextFieldsObervers()
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        self.toggleControls(enable: false)
        guard  let username = self.userNameTextField.text , let password = self.passwordTextField.text else {
            return
        }
        
        viewModel.onAction(action: .clickLoginButton(userName: username, password: password))
    }
    
    @IBAction func enterAsGuestButton(_ sender: Any) {
        self.toggleControls(enable: false)
        viewModel.onAction(action: .clickEnterAsGuestButton)
    }
    
    
    
    private func setupViews() {
        self.EnterAsGuestButton.addRadius(by: 5)
        self.loginButton.addRadius(by: 5)
        self.loginButton.setTitleColor(.black, for: .normal)
        self.loginButton.setTitleColor(.gray, for: .disabled)
        
        self.activityIndicator.isHidden = true
    }
    
    private func setupObservers() {
        viewModel.stateObservable
            .subscribe(onNext: {
                switch $0 {
                case .none:
                    break
                case .loginSucceeded:
                    self.toggleControls(enable: true)
                    self.navigateToHomePageTabBarViewController()
                case .loginFailed(let errorMessage):
                    self.toggleControls(enable: true)
                    AlertMessages.shared.showMessage(title: "Error", message: errorMessage, in: self)
                    
                }
            }).disposed(by: disposeBag)
    }
    
    
    private func setupTextFieldsObervers() {
        Observable.combineLatest(self.userNameTextField.rx.text, self.passwordTextField.rx.text) { text1 , text2 in
            return text1?.count ?? 0 > 0 && text2?.count ?? 0 > 0
        }.subscribe (onNext:{ (enable) in
            self.loginButton.isEnabled = enable
        }).disposed(by: disposeBag)
    }
    
    private func toggleControls(enable:Bool) {
        DispatchQueue.main.async {
            self.userNameTextField.isEnabled = enable
            self.passwordTextField.isEnabled = enable
            self.EnterAsGuestButton.isEnabled = enable
            
            self.activityIndicator.isHidden = !enable
            if !enable {
                self.activityIndicator.startAnimating()
            }else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    private func navigateToHomePageTabBarViewController() {
        DispatchQueue.main.async {
            if let homePageTabBarViewController = self.storyboard?.instantiateViewController(identifier: storyBoardIDS.homePageTabBarController.rawValue) as? UITabBarController {
                homePageTabBarViewController.modalPresentationStyle = .fullScreen
                self.present(homePageTabBarViewController, animated: true, completion: nil)
            }
        }
        
    }
    
   
    
    
}

