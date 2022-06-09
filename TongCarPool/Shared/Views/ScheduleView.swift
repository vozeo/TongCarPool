//
//  ScheduleView.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/1.
//

import Foundation
import SwiftUI

struct ScheduleView: View {
    var schedule: Schedule
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "car")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .foregroundColor(.white)
                .padding(.all, 20)

            VStack(alignment: .leading) {
                Text(schedule.title)
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Text(dateToString(schedule.departTime))
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.black)
                HStack {
                    Text(String(format: "Waiting %d of %d people", schedule.targetParticipants - schedule.currentParticipants!, schedule.targetParticipants))
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.white)
                }
            }.padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: Double.random(in: 0.3...0.5), green: Double.random(in: 0.3...0.5), blue: Double.random(in: 0.3...0.5)))
        .modifier(ScheduleModifier())
        .padding(.all, 10)
    }
}

struct ScheduleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}

func dateToString(_ date: Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = dateFormat
    return formatter.string(from: date)
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(schedule: testSchedule)
    }
}
