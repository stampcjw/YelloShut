//
//  RideInfoDetailListViewController.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/11/10.
//

import UIKit

class RideInfoDetailListViewController: UIViewController {

    private let tableView = UITableView()
    
//    let detailList = ["01.월평동 입구", "02.A아파트 후문", "03.로얄로드", "04.유성고등학교 앞", "05.도안2블럭 후문", "06.월평동 후문"]
    
    var cellTitle: String?
    var selectedCell: Int?
    var detailSelectedCell: Int?
    
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title:"뒤로가기", style: .plain, target: self, action: #selector(onClickBackBarButton))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = leftButton
        self.title = cellTitle
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.register(RideDetailListTableViewCell.classForCoder(), forCellReuseIdentifier: RideDetailListTableViewCell.cellIdentifier)
    }
    
    // MARK:- Selectors
    @objc func onClickBackBarButton(_ sender: UIButton) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: true)
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

extension RideInfoDetailListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UserInfo.shared.detailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RideDetailListTableViewCell.cellIdentifier, for: indexPath) as? RideDetailListTableViewCell else { fatalError("unable to deque RideDetailListTableViewCell") }
        cell.textLabel?.text = UserInfo.shared.detailList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "NaverMap", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "RideInfoRegisterDetailViewController") as! RideInfoRegisterDetailViewController

        vc.isCellSelected = true
        vc.detailTitle = (tableView.cellForRow(at: indexPath)?.textLabel?.text)!
        vc.selectedCell = selectedCell!

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
        
        // VC stack에 쌓여있을 때 해당 VC만 걸러낼 경우
//        for obj in (self.navigationController?.viewControllers)! {
//            if obj is RideInfoRegisterDetailViewController {
//                let vc2: RideInfoRegisterDetailViewController =  obj as! RideInfoRegisterDetailViewController
//                print(#line, #function)
//                vc2.isCellSelected = true
//                vc2.detailTitle = (tableView.cellForRow(at: indexPath)?.textLabel?.text)!
//                _ = self.navigationController?.popToViewController(vc2, animated: true)
//                break
//            }
//        }
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return cellTitle
//    }
}
