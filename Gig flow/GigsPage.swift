//
//  GigsPage.swift
//  Gig flow
//
//  Created by Sean Mavangira on 11/3/2026.
//

import SwiftUI

struct GigsPage: View {
    @State private var selectedFiltered: GigFliter = .all
    @Bindable var gigStore: GigStore
    @State private var showForm = false
    
    // The sheet form
    @State private var title = ""
    @State private var deadLine = Date()
    @State private var clientName = ""
    @State private var selectedStatus: GigStatus = .draft
    @State private var estimatedHoursText = ""
    
    var filteredGigs: [Gig] {
        
        switch selectedFiltered {
            
        case .all:
            return gigStore.gigs
            
        case .active:
            return gigStore.gigs.filter { $0.isActive && !$0.isCompleted }
            
        case .pending:
            return gigStore.gigs.filter { $0.isCompleted && !$0.isPaid }
            
        case .completed:
            return gigStore.gigs.filter { $0.isCompleted }
        }
    }
    
    func resetForm(){
        title = ""
        clientName = ""
        selectedStatus = .draft
        estimatedHoursText = ""
        deadLine = Date()
    }
    var body: some View {
        VStack{
            
            Picker("Filter", selection: $selectedFiltered) {
                ForEach(GigFliter.allCases, id: \.self) { filter in
                    Text(filter.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            ScrollView{
                ForEach(filteredGigs){ gig in
                    
                }
            }
            Button{
                showForm = true
            }label: {
                HStack{
                    Spacer()
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.gray)
                        .padding()
                }
            }
            
        }
        .sheet(isPresented: $showForm){
            TextField("Title", text: $title)
                .padding()
                .frame(height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding()
                
            DatePicker("Deadline", selection: $deadLine, in: Date()..., displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding()
                .frame(height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding()
            
            TextField("Client Name", text: $clientName)
                .padding()
                .frame(height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding()
            
            HStack {
                        Text("Status") // Label on the left
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Menu {
                            ForEach(GigStatus.allCases) { status in
                                Button(status.rawValue) {
                                    selectedStatus = status
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedStatus.rawValue) // Selected value on the right
                                    .foregroundColor(.primary)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                            .frame(height: 34) // same height as other fields
                            .background(Color.clear)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 19)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding()
            
            TextField("Estimated Hours", text: $estimatedHoursText)
                .keyboardType(.numberPad)
                .padding()
                .frame(height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding()
            
            HStack{
                if !title.isEmpty && !estimatedHoursText.isEmpty && !clientName.isEmpty{
                    Button{
                        let hours = Int(estimatedHoursText) ?? 0
                        let newGig = Gig(
                            title: title,
                            dueDate: deadLine,
                            estimatedHours: hours,
                            status: selectedStatus
                        )
                        
                        gigStore.gigs.append(newGig)
                        resetForm()
                    }label: {
                        Text("Add")
                    }
                }
                
                Button{
                 showForm = false
                }label: {
                    Text("Cancel")
                }
            }
        }
    }
}
#Preview {
    GigsPage(gigStore: GigStore())
}
