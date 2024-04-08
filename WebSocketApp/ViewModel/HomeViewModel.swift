//
//  HomeViewModel.swift
//  WebSocketApp
//
//  Created by matvey on 08.04.2024.
//

import Foundation

class HomeViewModel: ObservableObject{
    @Published var message = [String]()
    private var webSocketTask: URLSessionWebSocketTask?
    let socketURL = "wss://demo.piesocket.com/v3/channel_123?api_key=msHHaJSiSnRtYBh7mLopQJZiKEv5g83MJyNeZOng&notify_self"
    var messageText: String = ""
    @Published var alert: AlertItem?
    
    init() {
        self.connect()
    }
    
    private func connect(){
        guard let url = URL(string: socketURL) else {return}
        let request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        webSocketTask?.receive(completionHandler: onReceive)
       
    }
    
    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
        webSocketTask?.receive(completionHandler: onReceive)

        if case .success(let message) = incoming {
            onMessage(message: message)
        }
        else if case .failure(let error) = incoming {
            alert = AlertContext.invalidResponse
        }
    }
    
    private func onMessage(message: URLSessionWebSocketTask.Message) {
        if case .string(let text) = message {
            DispatchQueue.main.async {
                self.message.append(text)
            }
        }
    }
    
    func sendMessage(){
        guard messageText.data(using: .utf8) != nil else { return }
               webSocketTask?.send(.string(messageText)) { error in
                   if let error = error {
                       self.alert = AlertContext.messageError
                   }
               }
        messageText = ""
    }
}
