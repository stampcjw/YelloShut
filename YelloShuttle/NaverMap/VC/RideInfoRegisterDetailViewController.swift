//
//  RideInfoRegisterDetailViewController.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/11/05.
//

import UIKit

class RideInfoRegisterDetailViewController: UIViewController {

    // MARK:- Properties for UI
    // MARK:- IBOutlets
    @IBOutlet weak var selectButton: UIButton!
    
    private let tableView = UITableView()
    
//    var drivers: [DriverInfo] = []
    var drivers: [UserInfo] = []
    
//    let rideInfo = ["노은고등학교", "충남고등학교", "대신고등학교"]
       
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title:"뒤로가기", style: .plain, target: self, action: #selector(onClickBarButtonItems(_:)))
        button.tag = 0
        return button
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title:"확인", style: .plain, target: self, action: #selector(onClickBarButtonItems(_:)))
        button.tag = 1
        return button
    }()

    var isCellSelected = false
    var detailTitle = ""
    var selectedCell = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "탑승정보 등록하기"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
        
        tableView.delegate = self
        tableView.dataSource = self
        
        createDrivers()
        setupView()
    }
    
    
    // MARK:- Private func
    // MARK: UI
    private func setupView() {
        makeMainTableView()
    }
    
    /**
     * @brief :  운행 기사 정보 TableView
     * @param :  -
     * @return :  -
     * @see : -
     * @author : Jungwon Cha
     * @date :  2020/11/05
     */
    private func makeMainTableView() {
        view.addSubview(tableView)
//        tableView.separatorStyle = .none        // 줄간격 표시 라인 삭제
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.register(DriverInfoTableViewCell.classForCoder(), forCellReuseIdentifier: DriverInfoTableViewCell.cellIdentifier)
        tableView.register(RideInfoListTableViewCell.classForCoder(), forCellReuseIdentifier: RideInfoListTableViewCell.cellIdentifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130
    }
    
    // MARK:- Private Func
    private func createDrivers() {
//        drivers.append(DriverInfo(driverPicture: UIImage(named: "ksh")!, driverName: "김수현", driverNumber: "010-1234-1234", driverCarNumber: "대전33삼1234", academy: "별이빛나는밤"))
//        drivers.append(DriverInfo(driverPicture: UIImage(named: "kkd")!, driverName: "강기둥", driverNumber: "010-2345-2345", driverCarNumber: "서울33일1234", academy: "싸이코아니야"))
//        drivers.append(DriverInfo(driverPicture: UIImage(named: "kbk")!, driverName: "고보결", driverNumber: "010-3456-3456", driverCarNumber: "33수1234", academy: "뭔가이뻐"))
        UserInfo.shared.inputDriver()
    }
    
    
    // MARK:- Selectors
    @objc func onClickBarButtonItems(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popViewController(animated: true)
        case 1:
            // TODO: root vc 로 가기
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popToRootViewController(animated: true)
        default: break
        }
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

extension RideInfoRegisterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 셀 높이 지정(유동)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 50
        } else {
            return UITableView.automaticDimension
        }
    }
    
    // 각 세션 헤더의 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // 헤더에 들어갈 뷰 반환
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 헤더 레이블
        let textHeader = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 30))
        textHeader.font = .systemFont(ofSize: 18)
        
        // 섹션별 타이틀
        if section == 0 {
            textHeader.text = "운행 기사 정보"
        } else {
            textHeader.text = "운행 노선 정보"
        }
        
        // 레이블 담을 컨테이너용 뷰 객체
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        v.backgroundColor = .lightGray
        v.addSubview(textHeader)
        
        return v
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return UserInfo.shared.rideInfo.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DriverInfoTableViewCell.cellIdentifier, for: indexPath) as? DriverInfoTableViewCell else { fatalError("unable to deque DriverInfoTableViewCell") }
//            let curLastItem = drivers[indexPath.row]
//
//            cell.driverImage.image = curLastItem.driverPicture ?? UIImage(named: "driver")
//            cell.driverName.text = curLastItem.driverName ?? ""
//            cell.driverNumber.text = curLastItem.driverNumber ?? ""
//            cell.driverCarNumber.text = curLastItem.driverCarNumber ?? ""
//            cell.academy.text = curLastItem.academy ?? ""
            
            cell.driverImage.image = UserInfo.shared.driverPicture ?? UIImage(named: "driver")
            cell.driverName.text = UserInfo.shared.driverName ?? ""
            cell.driverNumber.text = UserInfo.shared.driverNumber ?? ""
            cell.driverCarNumber.text = UserInfo.shared.driverCarNumber ?? ""
            cell.academy.text = UserInfo.shared.academy ?? ""
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RideInfoListTableViewCell.cellIdentifier, for: indexPath) as? RideInfoListTableViewCell else { fatalError("unable to deque RideInfoListTableViewCell") }

            if isCellSelected == false {
                cell.rideLabel.text = UserInfo.shared.rideInfo[indexPath.row]
                cell.rideNick.text = ""
            } else if isCellSelected == true {
                if selectedCell == indexPath.row {
                    cell.rideLabel.text = UserInfo.shared.rideInfo[selectedCell]
                    cell.rideNick.text = UserInfo.shared.detailList[selectedCell]
                } else {
                    cell.rideLabel.text = UserInfo.shared.rideInfo[indexPath.row]
                    cell.rideNick.text = UserInfo.shared.detailList[indexPath.row]
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let storyboard = UIStoryboard.init(name: "NaverMap", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "RideInfoDetailListViewController") as! RideInfoDetailListViewController
            vc.cellTitle = UserInfo.shared.rideInfo[indexPath.row]
            vc.selectedCell = indexPath.row
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
