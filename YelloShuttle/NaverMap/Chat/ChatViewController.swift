//
//  ChatViewController.swift
//  YelloShuttle
//
//  Created by Chadoli on 2020/12/08.
//

import UIKit
import Firebase
import Kingfisher

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK:- Properties
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textfield_message: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "뒤로가", style: .plain, target: self, action: #selector(onClickBarButtonItems(_:)))
        btn.tag = 0
        return btn
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "나가기", style: .plain, target: self, action: #selector(onClickBarButtonItems(_:)))
        btn.tag = 1
        return btn
    }()
    
    var uid: String?
    var chatRoomUid: String?
    
    var comments: [ChatModel.Comment] = []
    var userModel: UserModel?
    
    public var destinationUid: String?      // 나중에 내가 채팅할 상대의 UID
    
    var databaseRef: DatabaseReference?
    var observe: UInt?
    var peopleCount: Int?
    
    // MARK:- Selectors
    @objc func onClickBarButtonItems(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:     // 탑승정보 등록
            self.navigationController?.popViewController(animated: true)
//            guard let vc = storyboard?.instantiateViewController(withIdentifier: "ChatRoomsViewController") as? ChatRoomsViewController else { return }
//            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            print(#function, #line)
            exitChatroom()
            self.navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        uid = Auth.auth().currentUser?.uid
        sendButton.addTarget(self, action: #selector(createRoom), for: .touchUpInside)
        _ = checkChatRoom(true)
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        self.tabBarController?.tabBar.isHidden = false
        
        databaseRef?.removeObserver(withHandle: observe!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    // MARK:- Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.comments[indexPath.row].uid == uid {
            let view = tableView.dequeueReusableCell(withIdentifier: "MyMessageCell", for: indexPath) as! MyMessageCell
            view.label_message.text = self.comments[indexPath.row].message
            view.label_message.numberOfLines = 0
            
            if let time = self.comments[indexPath.row].timestamp {
                view.label_timestamp.text = time.todayTime
            }
            setReadCount(label: view.label_read_counter, position: indexPath.row)
            
            return view
        } else {
            let view = tableView.dequeueReusableCell(withIdentifier: "DestinationMessageCell", for: indexPath) as! DestinationMessageCell
            view.label_name.text = userModel?.userName
            view.label_message.text = self.comments[indexPath.row].message
            view.label_message.numberOfLines = 0
            
            let url = URL(string: (self.userModel?.profileImageUrl)!)
            view.imageview_profile.layer.cornerRadius = view.imageview_profile.frame.width / 2
            view.imageview_profile.clipsToBounds = true
            view.imageview_profile.kf.setImage(with: url)
            
            if let time = self.comments[indexPath.row].timestamp {
                view.label_timestamp.text = time.todayTime
            }
            setReadCount(label: view.label_read_counter, position: indexPath.row)
            
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK:- Selectors
    
    // keyboard frame size만큼 tableview 사이즈 조정(height)
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.bottomConstraint.constant = keyboardSize.height
        }
        
        UIView.animate(withDuration: 0,
                       animations: {
                        self.view.layoutIfNeeded()
                       }, completion: { complete in
                        if self.comments.count > 0 {
                            self.tableview.scrollToRow(at: IndexPath(item: self.comments.count - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
                       }
        })
    }

    @objc func keyboardWillHide(notification: Notification) {
        self.bottomConstraint.constant = 20
        self.view.layoutIfNeeded()
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func createRoom(_ sender: UIButton) {
        let createRoomInfo: Dictionary<String, Any> = [
            "users": [
                uid!: true,
                destinationUid!: true
            ]
        ]
        
        if chatRoomUid == nil {
            self.sendButton.isEnabled = false
            // 방생성 코드
            Database.database().reference().child("chatrooms").childByAutoId().setValue(createRoomInfo)
            if self.checkChatRoom(true) == "" {
                _ = self.checkChatRoom(false)
            }
        } else {
            let value: Dictionary<String, Any> = [
                "uid": uid!,
                "message": textfield_message.text!,
                "timestamp": ServerValue.timestamp()
            ]
            Database.database().reference().child("chatrooms").child(chatRoomUid!).child("comments").childByAutoId().setValue(value, withCompletionBlock: { err, ref in
                self.textfield_message.text = ""
            })
        }
    }
        
    func checkChatRoom(_ trig:Bool)-> String {
        var test:String = ""
        
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "users/"+uid!).queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value, with: { datasnapshot in

            if datasnapshot.exists() == true {
                for item in datasnapshot.children.allObjects as! [DataSnapshot] {
                    if let chatRoomdic = item.value as? [String : AnyObject] {
                        let chatModel = ChatModel(JSON: chatRoomdic)
                        if chatModel?.users[self.destinationUid!] == true {
                            self.chatRoomUid = item.key
                            test = self.chatRoomUid!
                            self.sendButton.isEnabled = true
                            if trig == true {
                                self.getDestinationInfo()
                            } else {
                                let value: Dictionary<String, Any> = [
                                    "uid": self.uid!,
                                    "message": self.textfield_message.text!,
                                    "timestamp": ServerValue.timestamp()
                                ]
                                Database.database().reference().child("chatrooms").child(self.chatRoomUid!).child("comments").childByAutoId().setValue(value, withCompletionBlock: { err, ref in
                                    self.textfield_message.text = ""
                                })
                            }
                        }
                    }
                }
            }
        })
        return test
    }
    
    func getDestinationInfo() {
        Database.database().reference().child("users").child(self.destinationUid!).observeSingleEvent(of: DataEventType.value, with: { datasnapshot in
            self.userModel = UserModel()
            self.userModel?.setValuesForKeys(datasnapshot.value as! [String : Any])
            self.getMessageList()
        })
    }
    
    func setReadCount(label: UILabel?, position: Int?) {
        let readCount = self.comments[position!].readUsers.count
        
        if peopleCount == nil {
            Database.database().reference().child("chatrooms").child(chatRoomUid!).child("users").observeSingleEvent(of: DataEventType.value, with: { datasnapshot in
                let dic = datasnapshot.value as! [String : Any]
                self.peopleCount = dic.count
                let noReadCount = self.peopleCount! - readCount
                
                if noReadCount > 0 {
                    label?.isHidden = false
                    label?.text = String(noReadCount)
                } else {
                    label?.isHidden = true
                }
            })
        } else {
            let noReadCount = self.peopleCount! - readCount
            
            if noReadCount > 0 {
                label?.isHidden = false
                label?.text = String(noReadCount)
            } else {
                label?.isHidden = true
            }
        }
    }
    
    // Message리스트 가져와서 tableview bottom으로 scroll
    func getMessageList() {
        databaseRef = Database.database().reference().child("chatrooms").child(self.chatRoomUid!).child("comments")
        observe = databaseRef?.observe(DataEventType.value, with: { datasnapshot in
            // 초기 nil 대응
//            if datasnapshot.exists() == false {
//                return
//            }
            self.comments.removeAll()
            
            var readUserDic: Dictionary<String, AnyObject> = [:]
            
            for item in datasnapshot.children.allObjects as! [DataSnapshot] {
                let key = item.key as String
                let comment = ChatModel.Comment(JSON: item.value as! [String : AnyObject])
                let comment_modify = ChatModel.Comment(JSON: item.value as! [String : AnyObject])
                comment_modify?.readUsers[self.uid!] = true
                readUserDic[key] = comment_modify?.toJSON() as! NSDictionary
                self.comments.append(comment!)
            }
            
            let nsDic = readUserDic as NSDictionary
            
            if self.comments.last?.readUsers.keys == nil {
                return
            }
            
            if !(self.comments.last?.readUsers.keys.contains(self.uid!))! {
                datasnapshot.ref.updateChildValues(nsDic as! [AnyHashable : Any], withCompletionBlock:  { err, ref in
                    self.tableview.reloadData()
                    
                    if self.comments.count > 0 {
                        self.tableview.scrollToRow(at: IndexPath(item: self.comments.count - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: false)
                    }
                })
            } else {
                self.tableview.reloadData()
                
                if self.comments.count > 0 {
                    self.tableview.scrollToRow(at: IndexPath(item: self.comments.count - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
                }
            }
        })
    }
    
    // 현재 방 나가기
    func exitChatroom() {
//        Database.database().reference().child("chatrooms").child(self.chatRoomUid!).removeValue()
        Database.database().reference().child("chatrooms").child(self.chatRoomUid!).child("comments").removeValue()
    }
}

extension Int {
    var todayTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        let date = Date(timeIntervalSince1970: Double(self)/1000)
        return dateFormatter.string(from: date)
    }
}

class MyMessageCell: UITableViewCell {
    @IBOutlet weak var label_message: UILabel!
    @IBOutlet weak var label_timestamp: UILabel!
    @IBOutlet weak var label_read_counter: UILabel!
    
}

class DestinationMessageCell: UITableViewCell {
    @IBOutlet weak var label_message: UILabel!
    @IBOutlet weak var imageview_profile: UIImageView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_timestamp: UILabel!
    @IBOutlet weak var label_read_counter: UILabel!
    
}
