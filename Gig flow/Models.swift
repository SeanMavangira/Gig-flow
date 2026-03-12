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
    
    
    @AppStorage("savedGigs") private var savedGigs: Data = Data()
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
    
    init(
        id: UUID = UUID(),
        title: String,
        dueDate: Date,
        estimatedHours: Int,
        isCompleted: Bool = false,
        isPaid: Bool = false
    ) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.estimatedHours = estimatedHours
        self.isCompleted = isCompleted
        self.isPaid = isPaid
    }
}
