//
//  ChatGPT_MemoAppApp.swift
//  ChatGPT_MemoApp
//
//  Created by FX on 2023/03/22.
//

import SwiftUI

@main
struct ChatGPT_MemoAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
