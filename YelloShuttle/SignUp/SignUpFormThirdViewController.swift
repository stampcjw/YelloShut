//
//  SignUpFormThirdViewController.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/10/28.
//

import UIKit
import Firebase
import SnapKit

class SignUpFormThirdViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK:- Properties for UI
    // MARK:- IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var overlapCheckButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "가입절차"
        
        setupView()

        idTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        nameTextField.delegate = self
        telTextField.delegate = self
        
    }
    
    // MARK:- Private Func
    // MARK: UI
    
    private func setupView() {
        makeRegisterView()
        makeRegisterLabel()
        makeImageView()
        makeIdTextField()
        makePasswordTextField()
        makeConfirmPasswordTextField()
        makeNameTextField()
        makeTelTextField()
        makeOverlapCheckButton()
        makeDoneButton()
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
        
        registerLabel.text = "가입자 정보"
        
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        registerLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        registerLabel.heightAnchor.constraint(equalTo: registerView.heightAnchor).isActive = true
        registerLabel.leadingAnchor.constraint(equalTo: registerView.leadingAnchor, constant: 10).isActive = true
        registerLabel.topAnchor.constraint(equalTo: registerView.topAnchor).isActive = true
    }
        
    private func makeImageView() {
        view.addSubview(imageView)
        
        imageView.image = UIImage(systemName: "photo")
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imagePicker)))
        
        imageView.snp.makeConstraints { m in
            m.width.height.equalTo(100)
            m.top.equalTo(registerView.snp.bottom).offset(20)
            m.centerX.equalTo(view.snp.centerX)
        }
    }
    private func makeIdTextField() {
        view.addSubview(idTextField)
        
        idTextField.placeholder = "ID"
        idTextField.borderStyle = .roundedRect
        idTextField.clearButtonMode = .whileEditing
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        idTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        idTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        idTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    private func makePasswordTextField() {
        view.addSubview(passwordTextField)
        
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.widthAnchor.constraint(equalTo: idTextField.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: idTextField.heightAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: idTextField.leadingAnchor).isActive = true
    }
    
    private func makeConfirmPasswordTextField() {
        view.addSubview(confirmPasswordTextField)
        
        confirmPasswordTextField.placeholder = "비밀번호 확인"
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.clearButtonMode = .whileEditing
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor).isActive = true
        confirmPasswordTextField.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor).isActive = true
        confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
    }
    
    private func makeNameTextField() {
        view.addSubview(nameTextField)
        
        nameTextField.placeholder = "이름"
        nameTextField.borderStyle = .roundedRect
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.widthAnchor.constraint(equalTo: confirmPasswordTextField.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: confirmPasswordTextField.heightAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: confirmPasswordTextField.leadingAnchor).isActive = true
    }
    
    private func makeTelTextField() {
        view.addSubview(telTextField)
        
        telTextField.placeholder = "전화번호"
        telTextField.borderStyle = .roundedRect
        telTextField.clearButtonMode = .whileEditing
        telTextField.translatesAutoresizingMaskIntoConstraints = false
        telTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
        telTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
        telTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        telTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
    }
    
    private func makeOverlapCheckButton() {
        view.addSubview(overlapCheckButton)
        
        overlapCheckButton.layer.cornerRadius = 17.0
        overlapCheckButton.backgroundColor = #colorLiteral(red: 0.3038145006, green: 0.5172435641, blue: 1, alpha: 1)
        overlapCheckButton.setTitle("중복확인", for: .normal)
        overlapCheckButton.setTitleColor(.white, for: .normal)
        
        overlapCheckButton.translatesAutoresizingMaskIntoConstraints = false
        overlapCheckButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        overlapCheckButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        overlapCheckButton.topAnchor.constraint(equalTo: idTextField.topAnchor, constant: 7.5).isActive = true
        overlapCheckButton.leadingAnchor.constraint(equalTo: idTextField.trailingAnchor, constant: 20).isActive = true
        overlapCheckButton.addTarget(self, action: #selector(onClickOverlapCheck(_:)), for: .touchUpInside)
    }
    
    private func makeDoneButton() {
        view.addSubview(doneButton)
        
        doneButton.backgroundColor = #colorLiteral(red: 0.773198545, green: 0.773329556, blue: 0.7731812596, alpha: 1)
        doneButton.setTitle("완료", for: .normal)
        doneButton.setTitleColor(.black, for: .normal)
        
        let guide = view.safeAreaLayoutGuide
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        doneButton.addTarget(self, action: #selector(onClickDone(_:)), for: .touchUpInside)
    }
    
    // MARK:- Selectors
    @objc func onClickOverlapCheck(_ sender: UIButton) {
        
    }
    
    @objc func imagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onClickDone(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: idTextField.text!, password: passwordTextField.text!) { user, err in
            let uid = user?.user.uid
            let image = self.imageView.image?.jpegData(compressionQuality: 0.1)
            let imageRef = Storage.storage().reference().child("userImages").child(uid!)
            imageRef.putData(image!, metadata: nil, completion: { StorageMetadata, error in
                imageRef.downloadURL(completion: { url, err in
                    let values = [
                        "userName" : self.nameTextField.text!,
                        "profileImageUrl" : url?.absoluteString,
                        "uid" : Auth.auth().currentUser?.uid
                    ]
                    Database.database().reference().child("users").child(uid!).setValue(values, withCompletionBlock: { err, ref in
                        if err == nil {
                            self.cancelEvent()
                        }
                    })
                })
            })
        }
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func cancelEvent() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK:- TextFieldDelegate
extension SignUpFormThirdViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        idTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        telTextField.resignFirstResponder()        
        return true
    }
}
