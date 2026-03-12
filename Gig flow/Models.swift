//
//  Models.swift
//  Gig flow
//
//  Created by Sean Mavangira on 11/3/2026.
//

import Foundation
import SwiftUI


@Observable
class GigStore{
    
    
    private var savedGigs: Data {
            get { UserDefaults.standard.data(forKey: "savedGigs") ?? Data() }
            set { UserDefaults.standard.set(newValue, forKey: "savedGigs") }
        }
    
    var gigs: [Gig] = [] {
        didSet {
            saveGigs()
        }
    }
    
    init() {
        loadGigs()
    }
    
    func saveGigs(){
        if let encode = try? JSONEncoder().encode(gigs){
            savedGigs = encode
        }
    }
    
    func loadGigs(){
        if let decode = try? JSONDecoder().decode([Gig].self, from: savedGigs){
            gigs = decode
        }
    }
    
}

enum Tabs: String{
    case Dashboard
    case Gigs
    case Timer
    case Earnings
    
    
}

struct Gig: Identifiable, Codable {
    
    let id: UUID
    var title: String
    var dueDate: Date
    var estimatedHours: Int
    
    var isCompleted: Bool
    var isPaid: Bool
    var isActive: Bool
    var status: GigStatus
    
    
    init(
        id: UUID = UUID(),
        title: String,
        dueDate: Date,
        estimatedHours: Int,
        isCompleted: Bool = false,
        isPaid: Bool = false,
        isActive: Bool = false,
        status: GigStatus
        
    ) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.estimatedHours = estimatedHours
        self.isCompleted = isCompleted
        self.isPaid = isPaid
        self.isActive = isActive
        self.status = status
    }
}

enum GigFliter: String, CaseIterable, Identifiable{
    var id: Self {self}
    
        case all = "All"
        case active = "Active"
        case pending = "Pending"
        case completed = "Completed"
}

enum GigStatus: String, CaseIterable, Identifiable, Codable {
    case draft = "Draft"
    case active = "Active"
    case completed = "Completed"
    case pendingPayment = "Pending Payment"
    
    var id: Self { self }
}
