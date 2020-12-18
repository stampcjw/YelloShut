//
//  RideInfoRegisterViewController.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/11/03.
//

import UIKit
import ContactsUI

class RideInfoRegisterViewController: UIViewController {

    // MARK:- Properties for UI
    // MARK:- IBOutlets
    @IBOutlet weak var driverInfoView: UIView!
    @IBOutlet weak var driverInfoLabel: UILabel!
    @IBOutlet weak var numTextField: UITextField!
    @IBOutlet weak var contactButton: UIButton!
    
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title:"뒤로가기", style: .plain, target: self, action: #selector(onClickBarButtonItems(_:)))
        button.tag = 0
        return button
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title:"다음", style: .plain, target: self, action: #selector(onClickBarButtonItems(_:)))
        button.tag = 1
        return button
    }()
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "탑승정보 등록하기"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
        
        setupView()
    }
    
    // MARK:- Private func
    // MARK: UI
    private func setupView() {
        makeDriverInfoView()
        makeDriverInfoLabel()
        makeNumTextField()
        makeContactButton()
    }
    
    /**
     * @brief :  상단 운행기사 정보 View
     * @param :  -
     * @return :  -
     * @see : -
     * @author : Jungwon Cha
     * @date :  2020/11/05
     */
    private func makeDriverInfoView() {
        view.addSubview(driverInfoView)
        
        driverInfoView.backgroundColor = .lightGray
        
        driverInfoView.translatesAutoresizingMaskIntoConstraints = false
        driverInfoView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        driverInfoView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        driverInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        driverInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    /**
     * @brief :  상단 "운행기사 정보 검색" Label
     * @param :  -
     * @return :  -
     * @see : -
     * @author : Jungwon Cha
     * @date :  2020/11/05
     */
    private func makeDriverInfoLabel() {
        driverInfoView.addSubview(driverInfoLabel)
        
        driverInfoLabel.text = "운행 기사 정보 검색"
        driverInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        driverInfoLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        driverInfoLabel.heightAnchor.constraint(equalTo: driverInfoView.heightAnchor).isActive = true
        driverInfoLabel.topAnchor.constraint(equalTo: driverInfoView.topAnchor).isActive = true
        driverInfoLabel.leadingAnchor.constraint(equalTo: driverInfoView.leadingAnchor, constant: 10).isActive = true
    }
    
    /**
     * @brief :  전화번호 입력, 혹은 검색된 전화번호 표시용 Textfield
     * @param :  0
     * @return :  0
     * @see : 0
     * @author : Jungwon Cha
     * @date :  2020/11/05
     */
    private func makeNumTextField() {
        view.addSubview(numTextField)
        
        numTextField.placeholder = "전화번호"
        numTextField.borderStyle = .roundedRect
        numTextField.clearButtonMode = .whileEditing
        numTextField.translatesAutoresizingMaskIntoConstraints = false
        numTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        numTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        numTextField.topAnchor.constraint(equalTo: driverInfoView.bottomAnchor, constant: 5).isActive = true
        numTextField.leadingAnchor.constraint(equalTo: driverInfoView.leadingAnchor, constant: 10).isActive = true
        
    }
    
    /**
     * @brief :  연락처 검색용 버튼
     * @param :  -
     * @return :  -
     * @see : -
     * @author : Jungwon Cha
     * @date :  2020/11/05
     */
    private func makeContactButton(){
        view.addSubview(contactButton)
        
        contactButton.layer.cornerRadius = 25.0
        contactButton.backgroundColor = #colorLiteral(red: 0.3038145006, green: 0.5172435641, blue: 1, alpha: 1)
        contactButton.setTitle("연락처", for: .normal)
        contactButton.setTitleColor(.white, for: .normal)
        
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        contactButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        contactButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        contactButton.topAnchor.constraint(equalTo: driverInfoView.bottomAnchor, constant: 5).isActive = true
        contactButton.leadingAnchor.constraint(equalTo: numTextField.trailingAnchor, constant: 10).isActive = true
        contactButton.addTarget(self, action: #selector(onClickContacts(_:)), for: .touchUpInside)
    }
    
    // MARK:- Selectors
    @objc func onClickBarButtonItems(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popViewController(animated: true)
        case 1:
            guard let vc = storyboard!.instantiateViewController(identifier: "RideInfoRegisterDetailViewController") as? RideInfoRegisterDetailViewController else { return }
            navigationController?.pushViewController(vc, animated: true)
        default:    break
        }
    }
        
    @objc func onClickContacts(_ sender: UIButton) {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RideInfoRegisterViewController: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contacts.forEach { (contact) in
            for data in contact.phoneNumbers {
                let phoneNo = data.value
                numTextField.text = phoneNo.stringValue
            }
        }
    }
}
