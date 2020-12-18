//
//  LoginViewController.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/10/23.
//

import UIKit
import CoreLocation
import Firebase

class LoginViewController: UIViewController {

    // MARK:- Properties for UI
    // MARK:- IBOutlets
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var autoLoginView: UIView!
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    @IBOutlet weak var autoLoginLabel: UILabel!
    @IBOutlet weak var corpLabel: UILabel!

    // MARK:- Location Manager
    let locationManager = CLLocationManager()
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false      // 자동으로 멈춤방지
        
        locationManager.distanceFilter = 100
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        
        setupView()
        
        try! Auth.auth().signOut()

        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.view.window?.rootViewController?.dismiss(animated: false, completion: {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.switchMain()
                })
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK:- Private Func
    // MARK: UI
    
    private func setupView() {
        makeLoginImage()
        makeTextFieldID()
        makeTextFieldPassword()
        makeLoginButton()
        makeSigninButton()
        makeAutoLoginView()
        makeAutoLoginSwitch()
        makeAutoLoginLabel()
        makeCorpLabel()
    }
    
    private func makeLoginImage() {
        view.addSubview(loginImage)
        
        loginImage.image = UIImage(named: "shuttlecock")
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        loginImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginImage.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 5).isActive = true
    }
    
    private func makeTextFieldID() {
        view.addSubview(idTextField)
        
        idTextField.placeholder = "ID"
        idTextField.borderStyle = .roundedRect
        idTextField.clearButtonMode = .whileEditing
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        idTextField.widthAnchor.constraint(equalToConstant: 240).isActive = true
        idTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        idTextField.topAnchor.constraint(equalTo: loginImage.bottomAnchor, constant: 20).isActive = true
        // iPhone SE2 : 67.5, iPhone 12 Pro Max : 94 기준이므로 최소값보다는 크게하여 TextField의 크기는 240이지만 유동적으로 세팅
//        textFieldID.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 67.5).isActive = true
//        textFieldID.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -67.5).isActive = true
    }
    
    private func makeTextFieldPassword() {
        view.addSubview(passwordTextField)
        
        passwordTextField.placeholder = "Password : 8 ~ 16"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.widthAnchor.constraint(equalTo: idTextField.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: idTextField.heightAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: idTextField.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: idTextField.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: idTextField.trailingAnchor).isActive = true
    }
    
    private func makeLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.layer.cornerRadius = 17.0
        loginButton.backgroundColor = #colorLiteral(red: 0.3038145006, green: 0.5172435641, blue: 1, alpha: 1)
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
        
        loginButton.addTarget(self, action: #selector(onClickLogin(_:)), for: .touchUpInside)
    }
    
    private func makeSigninButton() {
        view.addSubview(signinButton)
        
        signinButton.layer.cornerRadius = loginButton.layer.cornerRadius
        signinButton.backgroundColor = .yellow
        signinButton.setTitle("가입하기", for: .normal)
        signinButton.setTitleColor(.black, for: .normal)
        
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        signinButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor).isActive = true
        signinButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor).isActive = true
        signinButton.topAnchor.constraint(equalTo: loginButton.topAnchor).isActive = true
        signinButton.trailingAnchor.constraint(equalTo: idTextField.trailingAnchor).isActive = true
//        signinButton.leadingAnchor.constraint(greaterThanOrEqualTo: loginButton.trailingAnchor, constant: 5).isActive = true
        
        signinButton.addTarget(self, action: #selector(onCLickSignUp(_:)), for: .touchUpInside)
    }
    
    private func makeAutoLoginView() {
        view.addSubview(autoLoginView)
        
        autoLoginView.translatesAutoresizingMaskIntoConstraints = false
        autoLoginView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        autoLoginView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        autoLoginView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        autoLoginView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
    }
    
    private func makeAutoLoginSwitch() {
        autoLoginView.addSubview(autoLoginSwitch)
        
        let guide = autoLoginView.layoutMarginsGuide
        
        autoLoginSwitch.isOn = false
        autoLoginSwitch.translatesAutoresizingMaskIntoConstraints = false
        autoLoginSwitch.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        autoLoginSwitch.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    }
    
    private func makeAutoLoginLabel() {
        autoLoginView.addSubview(autoLoginLabel)
        
        autoLoginLabel.text = "자동로그인"
        
        autoLoginLabel.frame.size = CGSize(width: 150, height: 40)
        autoLoginLabel.backgroundColor = .white
        autoLoginLabel.textAlignment = .center
        
        autoLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        // TODO: Vertical Align이 잘 안되서 일단 수동으로 보정함, 차후 방법 찾으면 추가할 것
        autoLoginLabel.topAnchor.constraint(equalTo: autoLoginSwitch.topAnchor, constant: 5).isActive = true
        autoLoginLabel.leadingAnchor.constraint(equalTo: autoLoginSwitch.trailingAnchor, constant: 10).isActive = true
    }
    
    private func makeCorpLabel() {
        view.addSubview(corpLabel)

        corpLabel.text = "TAMISOFT"
        corpLabel.backgroundColor = .white
        corpLabel.textAlignment = .center
        
        let guide = view.safeAreaLayoutGuide
        
        corpLabel.translatesAutoresizingMaskIntoConstraints = false
        corpLabel.widthAnchor.constraint(equalTo: guide.widthAnchor).isActive = true
        corpLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        corpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        corpLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }

    // MARK:- selectors
    @objc func onClickLogin(_ sender: UIButton) {
        
        // Test시 귀찮으니 로그인 체크 안하게...
//        let error = validateFields()
//
//        if error != nil {
//            let alert = UIAlertController(title: "필드값이 잘못되었습니다.", message: error, preferredStyle: .alert)
//
//            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
//            alert.addAction(okAction)
//
//            present(alert, animated: true, completion: nil)
//        } else {
            //TODO: 로그인 처리 및 맵화면 이동
            // 모든 VC dismiss한 후 NaverMap VC를 root로 설정할 것
            
            Auth.auth().signIn(withEmail: idTextField.text!, password: passwordTextField.text!) { (user, err) in
                if err != nil {
                    let alert = UIAlertController(title: "Error", message: err.debugDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        
//        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.switchMain()
//        })

//            self.view.window?.rootViewController?.dismiss(animated: false, completion: {
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.switchMain()
//
//                let storyboard = UIStoryboard(name: "NaverMap", bundle: nil)
//                guard let vc = storyboard.instantiateViewController(identifier: "NaverMapViewController") as? NaverMapViewController else { return }
//                vc.modalPresentationStyle = .fullScreen
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController?.present(vc, animated: true, completion: nil)
//            })
//        }
    }
    
    @objc func onCLickSignUp(_ sender: UIButton) {
        let vc = storyboard!.instantiateViewController(identifier: "SignUpFormFirstViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:- Private funcs
    private func validateFields() -> String? {
        if idTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "모든 필드를 채우세요."
        }
        
        let clean = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(clean) == false {
            return "8~16자리,특수,숫자포함되야 함."
        }
        
        return nil
    }
}


// MARK:- TextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        print("\((idTextField.text) ?? "Empty")")
        
        idTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        print("\((idTextField.text) ?? "Empty")")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        print("\((idTextField.text) ?? "Empty")")
    }
    
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textFieldPassword.text!.count < 8 || textFieldPassword.text!.count > 16 {
//            textFieldPassword.layer.borderColor = UIColor.red.cgColor
//        } else {
//            textFieldPassword.layer.borderColor = UIColor.green.cgColor
//        }
//        return true
//    }
}

extension LoginViewController: CLLocationManagerDelegate {
    // 위치권한 설정이 '안함'으로 되어 있으면 alert 띄워서 앱의 위치권한 설정 화면으로 넘어가도록 함
    func locationCheck() {
        let alert = UIAlertController(title: "위치권한 설정이 '안함'으로 되어 있습니다.", message: "앱 설정 화면으로 가시겠습니까?\n '아니오'를 선택하시면 앱이 종료됩니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "네", style: .default) { (action: UIAlertAction) in
            UIApplication.shared.open(NSURL(string: UIApplication.openSettingsURLString)! as URL)
        }
        let noAction = UIAlertAction(title: "아니오", style: .destructive) { (action: UIAlertAction) in
            exit(0)
        }
        alert.addAction(noAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    // 위치권한 설정이 변경되었을 때
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.denied {
            // 위치권한 거부되었을 경우
            locationCheck()
        } else if status == CLAuthorizationStatus.authorizedAlways {
            // 위치권한 항상
            print("location permision approved always")
        } else if status == CLAuthorizationStatus.authorizedWhenInUse {
            // 앱 실행중 일시 사용
            print("location permision approved when in use")
        }
    }
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            print("Always authorized.")
        case .authorizedWhenInUse:
            print("Authorization granted only when app is in use.")
        case .denied, .notDetermined, .restricted:
            locationCheck()
            print("Not authorized.")
        @unknown default:
            print("Unknown.")
        }
        
        switch manager.accuracyAuthorization {
        case .fullAccuracy:
            print("User has granted full accuracy.")
        case .reducedAccuracy:
            print("User has only granted reduced accuracy.")
        @unknown default:
            print("Unknown.")
        }
    }
}
