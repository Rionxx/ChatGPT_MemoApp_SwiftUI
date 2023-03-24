//
//  AddView.swift
//  ChatGPT_MemoApp
//
//  Created by FX on 2023/03/22.
//

import SwiftUI
import OpenAISwift

struct AddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var title = ""
    @State private var content = ""
    @State private var gptArray: [String] = []
    private var client = OpenAISwift(authToken: "APIキーを入力")
    
    var body: some View {
        VStack {
            TextField("タイトル", text: $title)
                .font(.title)
            
            ScrollView {
                ForEach(gptArray, id: \.self) { message in
                    Text(message)
                    Spacer()
                }
                
                
                
                HStack {
                    TextField("質問を入力", text: $content)
                        .padding()
                        .background(Color.gray.opacity(0.5))
                        .padding()
                        .font(.body)
                        
                    Button("送信") {
                        send()
                    }
                }
                Spacer()
            }
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
    
    //ChatGPTで回答を表示する関数
    func send() {
        guard !content.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        gptArray.append("person: \(content)")
        client.sendCompletion(with: content, maxTokens: 500, completionHandler: {result in
                switch result {
                    case .success(let model):
                        DispatchQueue.main.async {
                            let output = model.choices.first?.text ?? ""
                            self.gptArray.append("ChatGPT: \(output)")
                            self.content = ""
                    }
                    case .failure:
                        break
                }
            })
    }
    
    
    //データを保存する関数
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
