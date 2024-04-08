//
//  Alert.swift
//  WebSocketApp
//
//  Created by matvey on 08.04.2024.
//

import SwiftUI


struct AlertItem: Identifiable{
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext{
   
    static let invalidResponse = AlertItem(title: Text("Receive Messge Error"), message: Text("Invalid message from the server"), dismissButton: .default(Text("OK")))
    
    static let messageError = AlertItem(title: Text("Message Error"), message: Text("Error sending message to server"), dismissButton: .default(Text("OK")))
    
    static let emptyField = AlertItem(title: Text("Message Error"), message: Text("Filed message is empty"), dismissButton: .default(Text("OK")))
    
    static let invalidError = AlertItem(title: Text("Invalid Error"), message: Text("Invalid Error from server"), dismissButton: .default(Text("OK")))
}
   
