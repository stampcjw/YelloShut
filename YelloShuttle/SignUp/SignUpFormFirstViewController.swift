//
//  SignUpFormFirstViewController.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/10/26.
//

import UIKit

class SignUpFormFirstViewController: UIViewController {

    // MARK:- Properties for UI
    // MARK:- IBOutlets
    
    @IBOutlet weak var agreeView: UIView!
    @IBOutlet weak var agreeTitleLabel: UILabel!
    @IBOutlet weak var allAgreeButton: UIButton!
    @IBOutlet weak var nessesaryLocationLabel: UILabel!
    @IBOutlet weak var nessesaryContactLabel: UILabel!
    @IBOutlet weak var optionContactLabel: UILabel!
    @IBOutlet weak var nLocationSwitch: UISwitch!
    @IBOutlet weak var nContactSwitch: UISwitch!
    @IBOutlet weak var oContactSwitch: UISwitch!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nLocationTextView: UITextView!
    @IBOutlet weak var nContactTextView: UITextView!
    @IBOutlet weak var oContactTextView: UITextView!
    @IBOutlet weak var nLocationView: UIView!
    @IBOutlet weak var nContactView: UIView!
    @IBOutlet weak var oContactView: UIView!
    
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title:"뒤로가기", style: .plain, target: self, action: #selector(onClickBackBarButton))
        return button
    }()
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "가입절차"
        self.navigationController?.isNavigationBarHidden = false
//        self.navigationItem.leftBarButtonItem = self.leftButton
        
        setupView()
    }

    // MARK:- Private Func
    // MARK: UI
    
    private func setupView() {
        makeAgreeView()
        makeAgreeTitleLabel()
        makeAllAgreeButton()
        makeNessesaryLocationLabel()
        makeNLocationSwitch()
        makeNLocationTextView()
        makeNessesaryContactLabel()
        makeNContactSwitch()
        makeNContactTextView()
        makeOptionContactLabel()
        makeOContactSwitch()
        makeOContactTextView()
        makeNextButton()
    }
    
    private func makeAgreeView() {
        view.addSubview(agreeView)
        
        agreeView.backgroundColor = .lightGray
        
        let guide = view.safeAreaLayoutGuide
        
        agreeView.translatesAutoresizingMaskIntoConstraints = false
        agreeView.widthAnchor.constraint(equalTo: guide.widthAnchor).isActive = true
        agreeView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        agreeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        agreeView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    }
        
    private func makeAgreeTitleLabel() {
        agreeView.addSubview(agreeTitleLabel)
        
        agreeTitleLabel.text = "개인정보 활용동의 절차"
        
        agreeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        agreeTitleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        agreeTitleLabel.heightAnchor.constraint(equalTo: agreeView.heightAnchor).isActive = true
        agreeTitleLabel.leadingAnchor.constraint(equalTo: agreeView.leadingAnchor, constant: 10).isActive = true
        agreeTitleLabel.topAnchor.constraint(equalTo: agreeView.topAnchor).isActive = true
    }
    
    private func makeAllAgreeButton() {
        agreeView.addSubview(allAgreeButton)
        
        allAgreeButton.layer.cornerRadius = 20.0
        allAgreeButton.backgroundColor = #colorLiteral(red: 0.3038145006, green: 0.5172435641, blue: 1, alpha: 1)
        allAgreeButton.setTitle("전체동의", for: .normal)
        allAgreeButton.setTitleColor(.white, for: .normal)
        
        allAgreeButton.translatesAutoresizingMaskIntoConstraints = false
        allAgreeButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        allAgreeButton.heightAnchor.constraint(equalTo: agreeTitleLabel.heightAnchor, constant: -10).isActive = true
        allAgreeButton.trailingAnchor.constraint(equalTo: agreeView.trailingAnchor, constant: -10).isActive = true
        allAgreeButton.topAnchor.constraint(equalTo: agreeTitleLabel.topAnchor, constant: 5).isActive = true
        
        allAgreeButton.addTarget(self, action: #selector(onCLickAllAgree(_:)), for: .touchUpInside)
    }
    
    private func makeNessesaryLocationLabel() {
        view.addSubview(nessesaryLocationLabel)
        
        nessesaryLocationLabel.text = "(필수) 위치정보 활용 동의"
        nessesaryLocationLabel.backgroundColor = .white
        nessesaryLocationLabel.textAlignment = .left
        
        nessesaryLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        nessesaryLocationLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nessesaryLocationLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nessesaryLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nessesaryLocationLabel.topAnchor.constraint(equalTo: agreeView.bottomAnchor).isActive = true
    }
    
    private func makeNLocationSwitch() {
        view.addSubview(nLocationSwitch)
        
        nLocationSwitch.isOn = false
        nLocationSwitch.translatesAutoresizingMaskIntoConstraints = false
        nLocationSwitch.topAnchor.constraint(equalTo: agreeView.bottomAnchor, constant: 15).isActive = true
        nLocationSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func makeNLocationTextView() {
        view.addSubview(nLocationView)

        nLocationView.layer.borderColor = UIColor.lightGray.cgColor
        nLocationView.layer.borderWidth = 1
        nLocationView.translatesAutoresizingMaskIntoConstraints = false
        nLocationView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        nLocationView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        nLocationView.topAnchor.constraint(equalTo: nessesaryLocationLabel.bottomAnchor).isActive = true
        nLocationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nLocationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        nLocationView.addSubview(nLocationTextView)
        nLocationTextView.text = """
            아따 씨부엉~~~
            아따 씨부엉~~~
            아따 씨부엉~~~
            아따 씨부엉~~~
            아따 씨부엉~~~
            아따 씨부엉~~~
            아따 씨부엉~~~
            """
        nLocationTextView.isEditable = false
        nLocationTextView.translatesAutoresizingMaskIntoConstraints = false
        nLocationTextView.topAnchor.constraint(equalTo: nLocationView.topAnchor).isActive = true
        nLocationTextView.leadingAnchor.constraint(equalTo: nLocationView.leadingAnchor).isActive = true
        nLocationTextView.trailingAnchor.constraint(equalTo: nLocationView.trailingAnchor).isActive = true
        nLocationTextView.bottomAnchor.constraint(equalTo: nLocationView.bottomAnchor).isActive = true
    }
    
    private func makeNessesaryContactLabel() {
        view.addSubview(nessesaryContactLabel)
        
        nessesaryContactLabel.text = "(필수) 연락처 활용 동의"
        nessesaryContactLabel.backgroundColor = .white
        nessesaryContactLabel.textAlignment = .left
        
        nessesaryContactLabel.translatesAutoresizingMaskIntoConstraints = false
        nessesaryContactLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nessesaryContactLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nessesaryContactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nessesaryContactLabel.topAnchor.constraint(equalTo: nLocationView.bottomAnchor).isActive = true
    }
    
    private func makeNContactSwitch() {
        view.addSubview(nContactSwitch)
        
        nContactSwitch.isOn = false
        nContactSwitch.translatesAutoresizingMaskIntoConstraints = false
        nContactSwitch.topAnchor.constraint(equalTo: nLocationView.bottomAnchor, constant: 15).isActive = true
        nContactSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func makeNContactTextView() {
        view.addSubview(nContactView)
        
        nContactView.layer.borderColor = UIColor.lightGray.cgColor
        nContactView.layer.borderWidth = 1
        nContactView.translatesAutoresizingMaskIntoConstraints = false
        nContactView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        nContactView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        nContactView.topAnchor.constraint(equalTo: nessesaryContactLabel.bottomAnchor).isActive = true
        nContactView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nContactView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        nContactView.addSubview(nContactTextView)
        
        nContactTextView.text = """
            아따 씨부엉~~~
            아따 씨부엉~~~
            아따 씨부엉~~~
            아따 씨부엉~~~
            아따 씨부엉~~~
            아따 씨부엉~~~
            아따 씨부엉~~~
            """
        nContactTextView.isEditable = false
        nContactTextView.translatesAutoresizingMaskIntoConstraints = false
        nContactTextView.topAnchor.constraint(equalTo: nContactView.topAnchor).isActive = true
        nContactTextView.leadingAnchor.constraint(equalTo: nContactView.leadingAnchor).isActive = true
        nContactTextView.trailingAnchor.constraint(equalTo: nContactView.trailingAnchor).isActive = true
        nContactTextView.bottomAnchor.constraint(equalTo: nContactView.bottomAnchor).isActive = true
    }
    
    private func makeOptionContactLabel() {
        view.addSubview(optionContactLabel)
        
        optionContactLabel.text = "(선택) 안심번호 등록"
        optionContactLabel.backgroundColor = .white
        optionContactLabel.textAlignment = .left
        
        optionContactLabel.translatesAutoresizingMaskIntoConstraints = false
        optionContactLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        optionContactLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        optionContactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        optionContactLabel.topAnchor.constraint(equalTo: nContactView.bottomAnchor).isActive = true
    }
    
    private func makeOContactSwitch() {
        view.addSubview(oContactSwitch)
        
        oContactSwitch.isOn = false
        oContactSwitch.translatesAutoresizingMaskIntoConstraints = false
        oContactSwitch.topAnchor.constraint(equalTo: nContactView.bottomAnchor, constant: 15).isActive = true
        oContactSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

    private func makeOContactTextView() {
        view.addSubview(oContactView)
        
        oContactView.layer.borderColor = UIColor.lightGray.cgColor
        oContactView.layer.borderWidth = 1
        oContactView.translatesAutoresizingMaskIntoConstraints = false
        oContactView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        oContactView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        oContactView.topAnchor.constraint(equalTo: optionContactLabel.bottomAnchor).isActive = true
        oContactView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        oContactView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        oContactView.addSubview(oContactTextView)
        
        oContactTextView.text = """
                        아따 씨부엉~~~
                        아따 씨부엉~~~
                        아따 씨부엉~~~
                        아따 씨부엉~~~
                        아따 씨부엉~~~
                        아따 씨부엉~~~
                        아따 씨부엉~~~
                        """
        oContactTextView.isEditable = false
        oContactTextView.translatesAutoresizingMaskIntoConstraints = false
        oContactTextView.topAnchor.constraint(equalTo: oContactView.topAnchor).isActive = true
        oContactTextView.leadingAnchor.constraint(equalTo: oContactView.leadingAnchor).isActive = true
        oContactTextView.trailingAnchor.constraint(equalTo: oContactView.trailingAnchor).isActive = true
        oContactTextView.bottomAnchor.constraint(equalTo: oContactView.bottomAnchor).isActive = true
    }
    
    private func makeNextButton() {
        view.addSubview(nextButton)
        
        nextButton.backgroundColor = #colorLiteral(red: 0.773198545, green: 0.773329556, blue: 0.7731812596, alpha: 1)
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        
        let guide = view.safeAreaLayoutGuide
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        nextButton.addTarget(self, action: #selector(onClickNext(_:)), for: .touchUpInside)
    }
    
    // MARK:- Selectors
    @objc func onCLickAllAgree(_ sender: UIButton) {
        nLocationSwitch.isOn = true
        nContactSwitch.isOn = true
        oContactSwitch.isOn = true
    }
    
    @objc func onClickBackBarButton(_ sender: UIBarButtonItem) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickNext(_ sender: UIButton) {
        if (nLocationSwitch.isOn == false) || (nContactSwitch.isOn == false) {  // 필수항목 선택 안했을 경우 알람띄우고 머물기
            let alert = UIAlertController(title: "필수항목 선택", message: "필수항목을 선택하지 않았습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else if oContactSwitch.isOn == true {     // 안심번호 등록 선택했을 경우
            let vc = storyboard!.instantiateViewController(identifier: "SignUpFormSecondViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        } else {    // 안심번호 등록 선택 안했을 경우
            let vc = storyboard!.instantiateViewController(identifier: "SignUpFormThirdViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
