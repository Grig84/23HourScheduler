//
//  Weeks.swift
//  23HourScheduler
//
//  Created by Will Dirkswager on 12/5/23.
//

import SwiftUI

struct Weeks: View {
    let defaults = UserDefaults.standard
    @State var reloads: Int
    
    func reload() -> Void {
        reloads += 1
    }
    
    var body: some View {
        let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        ForEach(days, id: \.self) { day in
                            Days(weeks: self, day: day, startHour: defaults.integer(forKey: "StartTime"), endHour: defaults.integer(forKey: "EndTime"))
                        }
                    }
                    NavigationLink {
                        Settings(weeks: self)
                    } label: {
                        Text("Settings")
                            .font(.title)
                            .foregroundStyle(.black)
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
