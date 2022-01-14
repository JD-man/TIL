//
//  ViewController.swift
//  SocketChat
//
//  Created by JD_MacMini on 2022/01/13.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import RxKeyboard
import RxGesture
import Alamofire

// Socket
// 1. connect : handshake (header같은거)
// 2. on: 계속 듣고있음
// 3. emit: 보내는거
// 4. disconnect: 연결끊기

class ChatViewController: UIViewController {
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNjVjYmUzNDViZDllZDBjN2Q0ZiIsImlhdCI6MTY0MjEyMDc5NiwiZXhwIjoxNjQyMjA3MTk2fQ.kaFRhZyHya_hw8WLlblAYgQ56Utuh1vWU2OdKRQiwoQ"
    
    let username = "JDman"
    
    let url = "http://test.monocoding.com:1233/chats"
    var list: [Chat] = []
    
    
    let messageRelay = PublishRelay<[Chat]>()
    
    var disposeBag = DisposeBag()
    
    let messageTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MeTableViewCell.self, forCellReuseIdentifier: MeTableViewCell.identifier)
        tableView.register(YouTableViewCell.self, forCellReuseIdentifier: YouTableViewCell.identifier)
        return tableView
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.backgroundColor = .lightGray
        textView.layer.cornerRadius = 10
        textView.font = .systemFont(ofSize: 20, weight: .medium)
        return textView
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemPink
        button.tintColor = .systemBackground
        button.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        binding()
        requestChats()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getMessage(notification:)),
                                               name: NSNotification.Name("getMessage"),
                                               object: nil)
    }
    
    @objc private func getMessage(notification: NSNotification) {
        let chat = notification.userInfo!["chat"] as! String
        let name = notification.userInfo!["name"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
        
        let value = Chat(text: chat,
                         userID: "",
                         name: name,
                         username: "",
                         id: "",
                         createdAt: createdAt,
                         updatedAt: "",
                         v: -1,
                         lottoID: "")
        list.append(value)
        messageRelay.accept(list)        
        messageTableView.scrollToRow(at: IndexPath(row: list.count - 1, section: 0),
                                     at: .bottom, animated: false)
    }
    
    private func viewConfig() {
        view.backgroundColor = .systemBackground
        view.addSubview(messageTableView)
        view.addSubview(messageTextView)
        view.addSubview(sendButton)
        
        messageTextView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view).multipliedBy(0.8)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        sendButton.snp.makeConstraints { make in
            make.leading.equalTo(messageTextView.snp.trailing).offset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.bottom.equalTo(messageTextView)
            make.height.equalTo(40)
        }
        
        messageTableView.snp.makeConstraints { make in
            make.bottom.equalTo(messageTextView.snp.top)
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func binding() {
        messageRelay
            .asDriver(onErrorJustReturn: [])
            .drive(messageTableView.rx.items) { [weak self] tableView, row, element in
                if element.name == self!.username {
                    let cell = tableView.dequeueReusableCell(withIdentifier: MeTableViewCell.identifier) as! MeTableViewCell
                    cell.messageLabel.text = element.text + " - " + element.name
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: YouTableViewCell.identifier) as! YouTableViewCell
                    cell.messageLabel.text = element.text + " - " + element.name
                    return cell
                }
            }.disposed(by: disposeBag)
        
        sendButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.postChats(message: self!.messageTextView.text!)
            }).disposed(by: disposeBag)
        
        messageTextView.rx.didChange
            .bind { [weak self] in
                self?.messageTextView.snp.updateConstraints({ make in
                    make.height.equalTo(self!.messageTextView.contentSize)
                })
            }.disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] height in
                self?.messageTextView.snp.updateConstraints({ make in
                    make.bottom
                        .equalTo(self!.view.safeAreaLayoutGuide)
                        .offset(-height + self!.view.safeAreaInsets.bottom)
                })
            }).disposed(by: disposeBag)
        
        view.rx
            .tapGesture()
            .when(.ended)
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            }).disposed(by: disposeBag)
    }
    
    //DB에 마지막 채팅 시간을 저장하고 요청시 그 시간 이후 채팅을 가져온다.
    func requestChats() {
        let header: HTTPHeaders = [
            "Authorization" : "Bearer \(token)",
            "Accept" : "application/json"
        ]
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: [Chat].self) { [weak self] response in
                switch response.result {
                case .success(let value):
                    self?.list = value
                    self?.messageRelay.accept(value)
                    self?.messageTableView.scrollToRow(at: IndexPath(row: value.count - 1, section: 0),
                                                       at: .bottom,
                                                       animated: false)
                    SocketIOManager.shared.establishConnection()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func postChats(message: String) {
        let header: HTTPHeaders = [
            "Authorization" : "Bearer \(token)",
            "Accept" : "application/json"
        ]
        AF.request(url,
                   method: .post,
                   parameters: ["text" : message],
                   encoder: JSONParameterEncoder.default,
                   headers: header)
            .responseString { data in
                print("post succeed", data)
            }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SocketIOManager.shared.closeConnection()
    }
}

struct Chat: Codable {
    let text, userID, name, username: String
    let id, createdAt, updatedAt: String
    let v: Int
    let lottoID: String

    enum CodingKeys: String, CodingKey {
        case text
        case userID = "userId"
        case name, username
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
        case lottoID = "id"
    }
}

