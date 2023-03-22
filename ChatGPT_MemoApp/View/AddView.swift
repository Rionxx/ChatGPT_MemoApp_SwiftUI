//
//  AddView.swift
//  ChatGPT_MemoApp
//
//  Created by FX on 2023/03/22.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        VStack {
            TextField("タイトル", text: $title)
                .font(.title)
            TextEditor(text: $content)
                .font(.body)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action:{addChat()}) {
                    Text("保存")
                }
            }
        }
    }
    
    private func addChat() {
        let chat = Chat(context: viewContext)
        chat.title = title
        chat.content = content
        chat.createdAt = Date()
        chat.updatedAt = Date()
        try? viewContext.save()
        
        presentation.wrappedValue.dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
