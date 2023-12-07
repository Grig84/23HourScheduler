//
//  Details.swift
//  23HourScheduler
//
//  Created by Will Dirkswager on 12/5/23.
//

import SwiftUI

struct Details: View {
    @State var dday: Days
    @State var day: String
    @State var hour: Int
    let defaults = UserDefaults.standard
    @State private var val = ""
    
    func Next() -> Void {
        defaults.set(val, forKey: "\(day), \(hour), data")
        dday.weeks.reloadd.rel()
    }
    var body: some View {
        VStack {
            Text("Currently Doing:")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text(
                    (
                        defaults.string(forKey: "\(day), \(hour), data") == "" ||
                        defaults.string(forKey: "\(day), \(hour), data") == "Nothing"
                    ) ? "Not Doing Anything" : (defaults.string(forKey: "\(day), \(hour), data") ?? "Not Doing Anything")
            )
                .font(.headline)
                .padding(.bottom)
                .padding(.bottom)
                .padding(.bottom)
                .padding(.bottom)
            TextField("What Do You Want To Do?", text: $val)
                .textFieldStyle(.roundedBorder)
            .padding()
            Button {
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
    Details(dday: Days(weeks: Weeks(reloads: 1), day: "Monday", startHour: 6, endHour: 8), day: "Monday", hour: 4)
}
