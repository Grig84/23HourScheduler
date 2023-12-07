//
//  Weeks.swift
//  23HourScheduler
//
//  Created by Will Dirkswager on 12/5/23.
//

import SwiftUI

class reloader: ObservableObject {
    @Published var count: Int = 0
    
    func rel() {
        count+=1
    }
}

struct Weeks: View {
    @ObservedObject var reloadd = reloader()
    let defaults = UserDefaults.standard
    @State var reloads: Int
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    func reload() -> Void {
        reloads += 1
    }
    
    func nextWeek() -> Void {
        for day in days {
            for i in (defaults.integer(forKey: "StartTime")..<defaults.integer(forKey: "EndTime")) {
                defaults.set("", forKey: "\(day), \(i), data")
            }
        }
        defaults.set(defaults.integer(forKey: "weekNum")+1, forKey: "weekNum")
        reloadd.rel()
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        ForEach(days, id: \.self) { day in
                            Days(weeks: self, day: day, startHour: defaults.integer(forKey: "StartTime"), endHour: defaults.integer(forKey: "EndTime"))
                        }
                    }
                    HStack {
                        NavigationLink {
                            Settings(weeks: self)
                        } label: {
                            Text("Settings")
                                .font(.title)
                                .foregroundStyle(.black)
                        }
                        
                        .padding()
                        .padding()
                        .padding()
                        .padding()
                        
                        Button {
                            nextWeek()
                        } label: {
                            Text("Next Week")
                                .font(.title)
                                .foregroundStyle(.black)
                        }
                    }
                    
                    .padding()
                }
            }
        }
    }
}

#Preview {
    Weeks(reloads: 1)
}
