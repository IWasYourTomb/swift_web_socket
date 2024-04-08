//
//  ContentView.swift
//  WebSocketApp
//
//  Created by matvey on 08.04.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = HomeViewModel()
    @FocusState private var messageFocus: Bool
    
    var body: some View {
        VStack{
            List(vm.message, id: \.self){ message in
                Text(message)
            }
            HStack{
                TextField("Message", text: $vm.messageText)
                    .focused($messageFocus)
                    
                Button{
                    vm.sendMessage()
                    messageFocus = false
                }label: {
                    Text("Send")
                }
            }.padding(.all, 5)
        }
        .alert(item: $vm.alert){ alerts in
                    Alert(title: alerts.title, message: alerts.message, dismissButton: alerts.dismissButton)
                }
    }
}

#Preview {
    ContentView()
}
