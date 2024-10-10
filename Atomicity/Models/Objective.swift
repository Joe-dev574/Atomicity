//
//  Objective.swift
//  Atomicity
//
//  Created by Joseph DeWeese on 10/8/24.
//

import SwiftUI
import SwiftData

@Model
class Objective {
    var title: String
    var briefDescription: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    var priority: Int?
    var status: Status.RawValue
    @Relationship(inverse: \Focus.objectives)
    var focusList: [Focus]?
    @Relationship(deleteRule: .cascade)
    var notes: [Note]?
    
    
    init(
        title: String,
        briefDescription: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        priority: Int? = nil,
        status: Status = .Queue
    ) {
        self.title = title
        self.briefDescription = briefDescription
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.priority = priority
        self.status = status.rawValue
    }
    var icon: Image {
        switch Status(rawValue: status)! {
        case .Queue:
            Image(systemName: "calendar.badge.clock")
        case .inProgress:
            Image(systemName: "hourglass.circle")
        case .completed:
            Image(systemName: "checkmark.seal")
        }
    }
}


enum Status: Int, Codable, Identifiable, CaseIterable {
    case Queue, inProgress, completed
    var id: Self {
        self
    }
    var descr: LocalizedStringResource {
        switch self {
        case .Queue:
            "Queue"
        case .inProgress:
            "In Progress"
        case .completed:
            "Completed"
        }
    }
}
