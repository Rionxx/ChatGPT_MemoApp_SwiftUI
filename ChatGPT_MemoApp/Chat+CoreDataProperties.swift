//
//  Chat+CoreDataProperties.swift
//  ChatGPT_MemoApp
//
//  Created by FX on 2023/03/22.
//
//

import Foundation
import CoreData


extension Chat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chat> {
        return NSFetchRequest<Chat>(entityName: "Chat")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var createdAt: Date?

}

extension Chat : Identifiable {
    public var stringUpdatedAt: String { dateFomatter(date: updatedAt ?? Date()) }
        
    func dateFomatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

        return dateFormatter.string(from: date)
    }
}
