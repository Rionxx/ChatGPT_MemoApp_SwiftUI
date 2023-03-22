//
//  HomeView.swift
//  ChatGPT_MemoApp
//
//  Created by FX on 2023/03/22.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Chat.entity(),
        sortDescriptors: [NSSortDescriptor(key: "updatedAt", ascending: false)],
        animation: .default
    ) var fetchedChatList: FetchedResults<Chat>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fetchedChatList) { chat in
                    VStack {
                        Text(chat.title ?? "")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .lineLimit(1)
                        HStack {
                            Text(chat.stringUpdatedAt)
                                .font(.caption)
                                .lineLimit(1)
                            Text(chat.content ?? "")
                                .font(.caption)
                                .lineLimit(1)
                            Spacer()
                            
                        }
                    }
                }
            }
            .navigationTitle("チャットリスト")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddView()) {
                        Text("新規作成")
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
