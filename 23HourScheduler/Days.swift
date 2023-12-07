//
//  Days.swift
//  23HourScheduler
//
//  Created by Will Dirkswager on 12/5/23.
//

import SwiftUI

struct Days: View {
    @State var weeks: Weeks
    @State var day: String
    @State var startHour: Int
    @State var endHour: Int
    @State var reloads = 0
    let defaults = UserDefaults.standard
    
    func reload() -> Void {
        weeks.reload()
    }
    func updateWeek() -> some View {
        defaults.set(defaults.integer(forKey: "weekNum"), forKey: "\(day) randIcont")
        defaults.set(Int.random(in: startHour..<endHour+1), forKey: "\(day) randI")
        return EmptyView()
    }
    
    var body: some View {
        if defaults.integer(forKey: "\(day) randIcont") != defaults.integer(forKey: "weekNum") {
            updateWeek()
        }
        let randI = defaults.integer(forKey: "\(day) randI")
        VStack {
            Text(day)
                .font(.largeTitle)
            ForEach(startHour..<endHour, id: \.self) { i in
                if i != ((randI > (endHour-1)) ? endHour-1 : randI) {
                    NavigationLink {
                        Details(dday: self, day: day, hour:i)
                    } label: {
                        Text("\(i):00")
                            .foregroundStyle((
                                defaults.string(forKey: "\(day), \(i), data")=="Nothing" ||
                                defaults.string(forKey: "\(day), \(i), data") == nil ||
                                defaults.string(forKey: "\(day), \(i), data") == ""
                            ) ? .black : .gray)
                            .frame(width: 60, height: 30)
                            .font(.title2)
                    }
                    .padding(.horizontal)
                } else {
                    Text("Free Hour")
                        .font(.title)
                        .padding(0.5)
                }
            }
        }
        .padding()
    }
}

#Preview {
    Days(weeks: Weeks(reloads: 1), day: "Monday", startHour: 2, endHour: 6)
}
