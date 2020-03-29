//
//  ViewController.swift
//  testingScrollView
//
//  Created by Adir Burke on 27/3/20.
//  Copyright © 2020 WorkDesk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var activeTextField : UITextField?
    
    lazy var name : UITextField = {
       let tv = UITextField()
        tv.placeholder = "Name"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .red
        tv.delegate = self
        return tv
    }()
    
    lazy var email : UITextField = {
       let tv = UITextField()
        tv.placeholder = "email"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .yellow
        tv.delegate = self
        return tv
    }()
    lazy var password : UITextField = {
       let tv = UITextField()
        tv.placeholder = "password"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .blue
        tv.delegate = self
        return tv
    }()
    
    
    let mainScrollView : UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.alwaysBounceVertical = true
        s.backgroundColor = .orange
        s.showsVerticalScrollIndicator = false
        
        s.bounces = false
        return s
    }()
    
    let textFieldHeight : CGFloat = 50
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
        
        view.addSubview(mainScrollView)
        
        mainScrollView.fillSuperview()
//        mainScrollView.backgroundColor = .green
        
        mainScrollView.addSubview(name)
        mainScrollView.addSubview(email)
        mainScrollView.addSubview(password)
        
        name.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
        name.centerYAnchor.constraint(equalTo: mainScrollView.centerYAnchor, constant: 0).isActive = true
        name.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        
        email.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
        email.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        email.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        
        password.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor).isActive = true
        password.topAnchor.constraint(equalTo: email.bottomAnchor).isActive = true
        password.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
   
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardwillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        self.activeTextField = UITextField()
        
    }
    
    @objc func keyBoardwillChange(notification : Notification) {
        guard let keyBoardInfo = notification.userInfo else { return }
        guard let keyboardSize = (keyBoardInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height + 10
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        self.mainScrollView.contentInset = contentInset
        var viewRect = self.view.frame
        viewRect.size.height -= keyboardHeight
        guard let activeTextField = self.activeTextField else { return }
        
        let modifiedBy = activeTextField.frame.origin.y - viewRect.height + activeTextField.frame.height
        if (modifiedBy > 0) {
            let scrollPoint = CGPoint(x: 0, y: modifiedBy)
            self.mainScrollView.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    
    @objc func keyboardWillHide(notification : Notification) {
        self.mainScrollView.contentInset = .zero
    }

}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        activeTextField = nil
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
}

