//
//  Settings.swift
//  23HourScheduler
//
//  Created by Will Dirkswager on 12/5/23.
//

import SwiftUI

struct Settings: View {
    @State var weeks: Weeks
    @State private var startTime: Int = 0
    @State private var endTime: Int = 0
    let defaults = UserDefaults.standard
    
    func Next() -> some View {
        defaults.set(endTime, forKey: "EndTime")
        defaults.set(startTime, forKey: "StartTime")
        weeks.reload()
        return Weeks(reloads: 1)
    }
    
    var body: some View {
        VStack {
            Text("Start Of Day")
                .font(.largeTitle)
            TextField("Start Of Day", value: $startTime, format: .number)
                .textFieldStyle(.roundedBorder)
                .padding()
            Text("End Of Day")
                .font(.largeTitle)
            TextField("End Of Day", value: $endTime, format: .number)
                .textFieldStyle(.roundedBorder)
                .padding()
            NavigationLink {
                Next()
            } label: {
                Text("Save")
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                    .padding()
            }
        }
    }
    
    
}


#Preview {
    Settings(weeks: Weeks(reloads: 1))
}
