//
//  SocketIOManager.swift
//  SocketChat
//
//  Created by JD_MacMini on 2022/01/14.
//

import Foundation
import SocketIO

final class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    
    // 서버와 메세지를 주고받기 위한 클래스
    var manager: SocketManager!
    
    // 클라이언트 소켓
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        let url = URL(string: "http://test.monocoding.com:1233")!
        manager = SocketManager(socketURL: url, config: [
            //.log(true),
            .compress,
            .extraHeaders(["auth" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNjVjYmUzNDViZDllZDBjN2Q0ZiIsImlhdCI6MTY0MjEyMDc5NiwiZXhwIjoxNjQyMjA3MTk2fQ.kaFRhZyHya_hw8WLlblAYgQ56Utuh1vWU2OdKRQiwoQ"])
            ])
        
        socket = manager.defaultSocket // "/"로 된 룸
        
        // 소켓 연결 메서드
        socket.on(clientEvent: .connect) { data, ack in
            print("Socket is connected", data, ack)
        }
        
        // 소켓 연결 해제 메서드
        socket.on(clientEvent: .disconnect) { data, ack in
            print("Socket is disconnected", data, ack)
        }
        
        // 소켓 채팅을 듣는 메서드. 이벤트 : sesac
        // 데이터 수신 -> 디코딩 -> 모델에 추가 -> 갱신
        socket.on("sesac") { dataArr, ack in
            //print("received sesac", dataArr, ack)
            let data = dataArr[0] as! NSDictionary
            let chat = data["text"] as! String
            let name = data["name"] as! String
            let createAt = data["createdAt"] as! String
            
            //print("chat check", chat, name, createAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: [
                "chat" : chat,
                "name" : name,
                "createdAt" : createAt
            ])
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage() {
        socket.emit("sesac", "data...")
    }
}
