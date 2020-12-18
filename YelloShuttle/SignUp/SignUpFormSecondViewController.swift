//
//  SignUpFormSecondViewController.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/10/26.
//

import UIKit
import ContactsUI

class SignUpFormSecondViewController: UIViewController {

    // MARK:- Properties for UI
    // MARK:- IBOutlets
    
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var registerTextView: UITextView!
    @IBOutlet weak var num1TextField: UITextField!
    @IBOutlet weak var num2TextField: UITextField!
    @IBOutlet weak var contact1Button: UIButton!
    @IBOutlet weak var contact2Button: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: #selector(onClickBackBarButton))
        return button
    }()
    
    // MARK:- Properties for Internel Communication
    var contact1 = 0
    var contact2 = 0
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "가입절차"
//        self.navigationItem.leftBarButtonItem = self.leftButton

        setupView()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.topItem?.title = "가입절차"
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        self.navigationController?.isNavigationBarHidden = true
//    }
    
    // MARK:- Private Func
    // MARK: UI
    
    private func setupView() {
        makeRegisterView()
        makeRegisterLabel()
        makeRegisterTextView()
        makeTextFieldNum1()
        makeContact1Button()
        makeTextFieldNum2()
        makeContact2Button()
        makeConfirmButton()
    }
    
    private func makeRegisterView() {
        view.addSubview(registerView)
        
        registerView.backgroundColor = .lightGray
        
        let guide = view.safeAreaLayoutGuide
        
        registerView.translatesAutoresizingMaskIntoConstraints = false
        registerView.widthAnchor.constraint(equalTo: guide.widthAnchor).isActive = true
        registerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    }
    
    private func makeRegisterLabel() {
        registerView.addSubview(registerLabel)
        
        registerLabel.text = "안심번호 등록 절차"
        
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        registerLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        registerLabel.heightAnchor.constraint(equalTo: registerView.heightAnchor).isActive = true
        registerLabel.leadingAnchor.constraint(equalTo: registerView.leadingAnchor, constant: 10).isActive = true
        registerLabel.topAnchor.constraint(equalTo: registerView.topAnchor).isActive = true
    }

    private func makeRegisterTextView() {
        view.addSubview(registerTextView)
        
        registerTextView.translatesAutoresizingMaskIntoConstraints = false
        registerTextView.textAlignment = NSTextAlignment.justified
        registerTextView.textColor = .black
        registerTextView.backgroundColor = .white
        registerTextView.text = " 안심번호(보호자) 연락처를 등록하시면 승/하차 시 등록된 연락처로 문자를 보내 드립니다.\n최대 2개까지 등록 가능합니다."
        registerTextView.isEditable = false
        registerTextView.isScrollEnabled = false
        registerTextView.font = UIFont.preferredFont(forTextStyle: .body)
        
        registerTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        registerTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        registerTextView.leadingAnchor.constraint(equalTo: registerView.leadingAnchor, constant: 10).isActive = true
        registerTextView.trailingAnchor.constraint(equalTo: registerView.trailingAnchor, constant: -10).isActive = true
        registerTextView.topAnchor.constraint(equalTo: registerView.bottomAnchor).isActive = true
    }
    
    private func makeTextFieldNum1() {
        view.addSubview(num1TextField)
        
        num1TextField.placeholder = "안심번호1"
        num1TextField.borderStyle = .roundedRect
        num1TextField.clearButtonMode = .whileEditing
        num1TextField.translatesAutoresizingMaskIntoConstraints = false
        num1TextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        num1TextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        num1TextField.leadingAnchor.constraint(equalTo: registerView.leadingAnchor, constant: 10).isActive = true
        num1TextField.topAnchor.constraint(equalTo: registerTextView.bottomAnchor).isActive = true
    }
    
    private func makeContact1Button() {
        view.addSubview(contact1Button)
        
        contact1Button.layer.cornerRadius = 25.0
        contact1Button.backgroundColor = #colorLiteral(red: 0.3038145006, green: 0.5172435641, blue: 1, alpha: 1)
        contact1Button.setTitle("연락처", for: .normal)
        contact1Button.setTitleColor(.white, for: .normal)
        contact1Button.tag = 1
        
        contact1Button.translatesAutoresizingMaskIntoConstraints = false
        contact1Button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        contact1Button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        contact1Button.leadingAnchor.constraint(equalTo: num1TextField.trailingAnchor, constant: 10).isActive = true
        contact1Button.topAnchor.constraint(equalTo: registerTextView.bottomAnchor).isActive = true
        contact1Button.addTarget(self, action: #selector(onClickContacts(_:)), for: .touchUpInside)
    }
    
    private func makeTextFieldNum2() {
        view.addSubview(num2TextField)
        
        num2TextField.placeholder = "안심번호2"
        num2TextField.borderStyle = .roundedRect
        num2TextField.clearButtonMode = .whileEditing
        num2TextField.translatesAutoresizingMaskIntoConstraints = false
        num2TextField.widthAnchor.constraint(equalTo: num1TextField.widthAnchor).isActive = true
        num2TextField.heightAnchor.constraint(equalTo: num1TextField.heightAnchor).isActive = true
        num2TextField.leadingAnchor.constraint(equalTo: num1TextField.leadingAnchor).isActive = true
        num2TextField.topAnchor.constraint(equalTo: num1TextField.bottomAnchor, constant: 10).isActive = true
    }

    private func makeContact2Button() {
        view.addSubview(contact2Button)
        
        contact2Button.layer.cornerRadius = 25.0
        contact2Button.backgroundColor = #colorLiteral(red: 0.3038145006, green: 0.5172435641, blue: 1, alpha: 1)
        contact2Button.setTitle("연락처", for: .normal)
        contact2Button.setTitleColor(.white, for: .normal)
        contact2Button.tag = 2
        
        contact2Button.translatesAutoresizingMaskIntoConstraints = false
        contact2Button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        contact2Button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        contact2Button.leadingAnchor.constraint(equalTo: num2TextField.trailingAnchor, constant: 10).isActive = true
        contact2Button.topAnchor.constraint(equalTo: num1TextField.bottomAnchor, constant: 10).isActive = true
        contact2Button.addTarget(self, action: #selector(onClickContacts(_:)), for: .touchUpInside)
    }
    
    private func makeConfirmButton() {
        view.addSubview(nextButton)
        
        nextButton.backgroundColor = #colorLiteral(red: 0.773198545, green: 0.773329556, blue: 0.7731812596, alpha: 1)
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        
        let guide = view.safeAreaLayoutGuide
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        nextButton.addTarget(self, action: #selector(onClickDone(_:)), for: .touchUpInside)
    }
    
    // MARK:- Selectors
    @objc func onClickBackBarButton(_ sender: UIBarButtonItem) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickDone(_ sender: UIButton) {
        if num1TextField.text == "" {
            let alert = UIAlertController(title: "안심번호 등록", message: "안심번호가 등록되지 않았습니다.\n계속 진행 하시겠습니까?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "확인", style: .default) { action in
                let vc = self.storyboard!.instantiateViewController(identifier: "SignUpFormThirdViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func onClickContacts(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            contact1 = 1
        case 2:
            contact2 = 1
        default:
            break
        }

        let picker = CNContactPickerViewController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}

extension SignUpFormSecondViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contacts.forEach { (contact) in
            for data in contact.phoneNumbers {
                let phoneNo = data.value
                if contact1 == 1 {
                    num1TextField.text = phoneNo.stringValue
                    contact1 = 0
                } else if contact2 == 1 {
                    num2TextField.text = phoneNo.stringValue
                    contact2 = 0
                }
            }
        }
    }
}
