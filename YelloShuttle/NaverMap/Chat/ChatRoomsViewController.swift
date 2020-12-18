//
//  ChatRoomsViewController.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/12/08.
//

import UIKit
import Firebase
import Kingfisher

class ChatRoomsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK:- Properties
    @IBOutlet weak var tableview: UITableView!
    
    var uid: String!
    var chatrooms: [ChatModel]! = []
    var destinationUsers: [String]! = []
    
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.uid = Auth.auth().currentUser?.uid
        self.getChatroomsList()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewDidLoad()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewDidLoad()
    }
    
    // MARK:- Private Funcs
    private func getChatroomsList() {
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "users/" + uid!).queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value, with: { datasnapshot in
            
            self.chatrooms.removeAll()
            for item in datasnapshot.children.allObjects as! [DataSnapshot] {
                if let chatroomdic = item.value as? [String : AnyObject] {
                    let chatModel = ChatModel(JSON: chatroomdic)
                    self.chatrooms.append(chatModel!)
                }
            }
            self.tableview.reloadData()
        })
    }
    
//    func setReadCount(label: UILabel?, position: Int?) {
//        let readCount = self.comments[position!].readUsers.count
//
//        if peopleCount == nil {
//            Database.database().reference().child("chatrooms").child(chatRoomUid!).child("users").observeSingleEvent(of: DataEventType.value, with: { datasnapshot in
//                let dic = datasnapshot.value as! [String : Any]
//                self.peopleCount = dic.count
//                let noReadCount = self.peopleCount! - readCount
//
//                if noReadCount > 0 {
//                    label?.isHidden = false
//                    label?.text = String(noReadCount)
//                } else {
//                    label?.isHidden = true
//                }
//            })
//        } else {
//            let noReadCount = self.peopleCount! - readCount
//
//            if noReadCount > 0 {
//                label?.isHidden = false
//                label?.text = String(noReadCount)
//            } else {
//                label?.isHidden = true
//            }
//        }
//    }
    
    // MARK:- Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatrooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath) as! CustomCell
        
        var destinationUid: String?
                
        for item in chatrooms[indexPath.row].users {
            if item.key != self.uid {
                destinationUid = item.key
                destinationUsers.append(destinationUid!)
            }
        }
        
        Database.database().reference().child("users").child(destinationUid!).observeSingleEvent(of: DataEventType.value, with: { datasnapshot in
            let userModel = UserModel()
            userModel.setValuesForKeys(datasnapshot.value as! [String : AnyObject])
            
            cell.label_title.text = userModel.userName
            
            let url = URL(string: userModel.profileImageUrl!)
            cell.imageview.layer.cornerRadius = cell.imageview.frame.width / 2
            cell.imageview.layer.masksToBounds = true
            cell.imageview.kf.setImage(with: url)
            
            if self.chatrooms[indexPath.row].comments.keys.count == 0 {
                return
            }
            
            let lastMessageKey = self.chatrooms[indexPath.row].comments.keys.sorted() { $0 > $1 }
            cell.label_lastmessage.text = self.chatrooms[indexPath.row].comments[lastMessageKey[0]]?.message
            let unixTime = self.chatrooms[indexPath.row].comments[lastMessageKey[0]]?.timestamp
            cell.label_timestamp.text = unixTime?.todayTime
            
            var totCnt = 0
            for item in lastMessageKey {        // 1:1대화방에 상대가 안읽었을 경우에만 카운트 증가
                if ((self.chatrooms[indexPath.row].comments[item]?.readUsers.count)! < 2) && ((self.chatrooms[indexPath.row].comments[item]?.readUsers.keys.contains(self.uid)) != true) {
                    totCnt += 1
                }
            }

            if totCnt > 0 {
                cell.label_read_counter.isHidden = false
                cell.label_read_counter.text = String(totCnt)
                self.tabBarController?.tabBar.items![3].badgeValue = String(totCnt)
            } else {
                cell.label_read_counter.isHidden = true
                self.tabBarController?.tabBar.items![3].badgeValue = nil
            }
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destinationUid = self.destinationUsers[indexPath.row]
        let view = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        view.destinationUid = destinationUid
        self.navigationController?.pushViewController(view, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class CustomCell: UITableViewCell {
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_lastmessage: UILabel!
    @IBOutlet weak var label_timestamp: UILabel!
    @IBOutlet weak var label_read_counter: UILabel!
    
}
