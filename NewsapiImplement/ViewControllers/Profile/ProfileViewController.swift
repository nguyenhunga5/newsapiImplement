//
//  ProfileViewController.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import BonMot

class ProfileViewController: BaseViewController {

    @IBOutlet weak var loggedContentView: UIView!
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var registerContentView: UIView!
    @IBOutlet weak var registerLabel: UILabel!
    
    @IBOutlet weak var countryContentView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    
    let labelStyle = StringStyle(
        .font(UIFont.systemFont(ofSize: 15)),
        .color(.gray)
    )
    
    let labelPrefixStyle = StringStyle(
        .font(UIFont.systemFont(ofSize: 15)),
        .color(.systemTeal)
    )
    
    let prefix = "<title>%@: </title>"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeCountryNotification(_:)),
                                               name: .countryChanged, object: nil)
        
        configCountryLabel()
        
        if ConfigService.shared.stored(for: .username) != nil {
            showLoggedUser()
        } else {
            showRegister()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .countryChanged, object: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func configCountryLabel() {
        let title = String(format: prefix, "Country")
        let countryStr = (title + ConfigService.supportCountryCode[ConfigService.shared.stored(for: .country)!]!)
        countryLabel.attributedText = countryStr.styled(with: labelStyle.byAdding(.xmlRules([
            .style("title", labelPrefixStyle)
        ])))
    }
    
    private func configUserLabel() {
        let title = String(format: prefix, "Welcome")
        let usernameStr = (title + ConfigService.shared.stored(for: .username)!)
        userLabel.attributedText = usernameStr.styled(with: labelStyle.byAdding(.xmlRules([
            .style("title", labelPrefixStyle)
        ])))
    }
    
    private func configRegisterLabel() {
        let title = String(format: prefix, "Don't have account?")
        let registerStr = (title + "Register now")
        registerLabel.attributedText = registerStr.styled(with: labelStyle.byAdding(.xmlRules([
            .style("title", labelPrefixStyle)
        ])))
    }
    
    func showLoggedUser() {
        configUserLabel()
        
        UIView.animate(withDuration: 0.15) {
            self.registerContentView.isHidden = true
            self.loggedContentView.isHidden = false
        }
    }
    
    func showRegister() {
        configRegisterLabel()
        UIView.animate(withDuration: 0.15) {
            self.registerContentView.isHidden = false
            self.loggedContentView.isHidden = true
        }
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        ConfigService.shared.store(nil, for: .username)
        showRegister()
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Register",
                                                message: "Please enter your username",
                                                preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Username"
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {[weak alertController] _ in
            alertController?.dismiss(animated: true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "Register", style: .default, handler: {
            [weak self, weak alertController] action in
            
            if let textField = alertController?.textFields?.first {
                
                if textField.text == nil || !textField.text!.isUsername {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self?.registerAction(self!)
                    }
                } else {
                    ConfigService.shared.store(textField.text!, for: .username)
                    self?.showLoggedUser()
                }
                
            } else {
                alertController?.dismiss(animated: true, completion: nil)
            }
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func changeCountryAction(_ sender: Any) {
        ConfigService.shared.changeCountry(from: self)
    }
    
    @objc func changeCountryNotification(_ notification: Notification) {
        configCountryLabel()
    }
}
