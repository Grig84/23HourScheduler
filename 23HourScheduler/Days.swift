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
    @State var startHour: Int = 0
    @State var endHour: Int = 12
    @State var reloads = 0
    let defaults = UserDefaults.standard
    
    func reload() -> Void {
        reloads+=1
    }
    
    var body: some View {
        let randI = Int.random(in: startHour..<endHour+1)
        VStack {
            Text(day)
                .font(.largeTitle)
            ForEach(startHour..<endHour, id: \.self) { i in
                if i != randI {
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
