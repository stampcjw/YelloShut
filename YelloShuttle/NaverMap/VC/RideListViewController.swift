//
//  RideListViewController.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/11/23.
//

import UIKit

//protocol TestProtocol {
//    func setRideInfo(rideinfo: String, detail: String)
//}

class RideListViewController: UIViewController {
    private let tableView = UITableView()
    
    // MARK: Properties
    @UseAutoLayout var optionButtonView = UIView()
    @UseAutoLayout var optionButton = UIButton()
    @UseAutoLayout var registButton = UIButton()
    @UseAutoLayout var editButton = UIButton()
    @UseAutoLayout var doneButton = UIButton()
    
    lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(onClickBarButtonItems(_:)))
        btn.tag = 1
        return btn
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title:"탑승정보 등록", style: .plain, target: self, action: #selector(onClickBarButtonItems(_:)))
        btn.tag = 0
        return btn
    }()

//    var delegate: TestProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "탑승지 리스트"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- Private Method
    // MARK:- Private Funcs
   

    private func setupView() {
        makeTableView()
//        makeOptionButtonView()
//        makeOptionSubButton()
//        makeOptionMainButton()
    }
    
    private func makeTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(RideListTableViewCell.classForCoder(), forCellReuseIdentifier: RideListTableViewCell.cellIdentifier)
    }
    
    private func makeOptionButtonView() {
        view.addSubview(optionButtonView)
        
        optionButtonView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        optionButtonView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        optionButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        optionButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    private func makeOptionSubButton() {
        let btns = [registButton, editButton, doneButton]
        let colors = [#colorLiteral(red: 0.9039819837, green: 0.2630831301, blue: 0.9470408559, alpha: 1), #colorLiteral(red: 0.4560150504, green: 0.9284182787, blue: 0.552947402, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)]
        let titles = ["Reg", "Edit", "Done"]
        
        for i in 0..<btns.count {
            optionButtonView.addSubview(btns[i])
            btns[i].layer.cornerRadius = 15.0
            btns[i].backgroundColor = colors[i]
            btns[i].setTitle(titles[i], for: .normal)
            btns[i].setTitleColor(.white, for: .normal)
            btns[i].setTitleColor(.highlightedLabel, for: .highlighted)
            btns[i].addTarget(self, action: #selector(onClickBarButtonItems(_:)), for: .touchUpInside)
            btns[i].tag = i + 1
            
            btns[i].widthAnchor.constraint(equalToConstant: 60).isActive = true
            btns[i].heightAnchor.constraint(equalToConstant: 60).isActive = true
            btns[i].trailingAnchor.constraint(equalTo: optionButtonView.trailingAnchor).isActive = true
            btns[i].bottomAnchor.constraint(equalTo: optionButtonView.bottomAnchor).isActive = true
        }
        
    }
    
    private func makeOptionMainButton() {
        optionButtonView.addSubview(optionButton)
        
        optionButton.layer.masksToBounds = true
        optionButton.layer.cornerRadius = 15.0
        optionButton.backgroundColor = #colorLiteral(red: 0.3923153281, green: 0.5790430903, blue: 0.9439979792, alpha: 1)    //#colorLiteral(red: 0.3923153281, green: 0.5790430903, blue: 0.9439979792, alpha: 1)
        optionButton.setTitle("+", for: .normal)
        optionButton.setTitleColor(.white, for: .normal)
        optionButton.setTitleColor(.highlightedLabel, for: .highlighted)
        optionButton.tag = 0
        
        optionButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        optionButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        optionButton.trailingAnchor.constraint(equalTo: optionButtonView.trailingAnchor).isActive = true
        optionButton.bottomAnchor.constraint(equalTo: optionButtonView.bottomAnchor).isActive = true
        optionButton.addTarget(self, action: #selector(onClickBarButtonItems(_:)), for: .touchUpInside)
    }
    
    /**
     * @brief :  수직타입 좌표값 계산해줌
     * @param :  distance ( CGFloat)
     * @return :  CGPoint
     * @see : -
     * @author : Jungwon Cha
     * @date :  2020/11/24
     */
    private func getVerticalPosition(distance: CGFloat) -> CGPoint {
        let x: CGFloat = optionButton.layer.position.x
        let y: CGFloat = optionButton.layer.position.y + distance
        
        return CGPoint(x: x, y: y)
    }
    
    // MARK:- Selectors
    @objc func onClickBarButtonItems(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:     // 탑승정보 등록
            guard let vc = storyboard!.instantiateViewController(identifier: "RideInfoRegisterViewController") as? RideInfoRegisterViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:     // 편집
            if sender.title == "편집" {
                tableView.setEditing(true, animated: true)
                sender.title = "완료"
            } else if sender.title == "완료" {
                tableView.setEditing(false, animated: true)
                tableView.reloadSections(IndexSet(0...0), with: UITableView.RowAnimation.automatic) // 편집 완료시 Cell Index 재정렬
                sender.title = "편집"
            }
            if UserInfo.shared.rideInfo.count == 0 {
                let alert = UIAlertController(title: "확인", message: "삭제할 경로가 없습니다.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okAction)
                
                present(alert, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    

}

extension RideListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInfo.shared.rideInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RideListTableViewCell.cellIdentifier, for: indexPath) as? RideListTableViewCell else { fatalError("unable to deque RideListTableViewCell") }
        
        cell.rideLabel.text = UserInfo.shared.rideInfo[indexPath.row]
        cell.rideNick.text = UserInfo.shared.detailList[indexPath.row]
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: RideListTableViewCell.cellIdentifier, for: indexPath) as? RideListTableViewCell else { fatalError("unable to deque RideListTableViewCell") }
//
////        self.delegate?.setRideInfo(rideinfo: cell.rideLabel.text!, detail: cell.rideNick.text ?? "")
//        
////        tabBarController?.selectedIndex = 1
//    }
    
    // 행 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // 편집모드 사용 유무
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 편집모드 - 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            UserInfo.shared.rideInfo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Delete text -> "삭제" 로 변경
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    // 목록순서 변경
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = UserInfo.shared.rideInfo[sourceIndexPath.row]
        UserInfo.shared.rideInfo.remove(at: sourceIndexPath.row)
        UserInfo.shared.rideInfo.insert(itemToMove, at: destinationIndexPath.row)
    }
}
