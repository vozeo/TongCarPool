//
//  ApplyScheduleView.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/6.
//

import SwiftUI

struct ApplyScheduleView: View {
    var schedule: Schedule
    var body: some View {
        VStack{
            HStack(alignment: .center) {
                Image(systemName: "car")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
                    .foregroundColor(.white)
                    .padding([.top, .horizontal], 20)
                
                VStack(alignment: .leading) {
                    Text(schedule.title)
                        .font(.system(size: 26, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    Text(dateToString(schedule.departTime))
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.black)
                    HStack {
                        Text(String.init(format: "Waiting %d of %d people", schedule.targetParticipants - schedule.currentParticipants!, schedule.targetParticipants))
                            .font(.system(size: 16, weight: .bold, design: .default))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.top, 10)
            ApplyStateText(textStatus: schedule.status)
                .padding(.top, -10)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: Double.random(in: 0.3...0.5), green: Double.random(in: 0.3...0.5), blue: Double.random(in: 0.3...0.5)))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
        .padding(.all, 10)
    }
}

struct ApplyStateText: View {
    @State private var backColor: Color
    @State private var stateText: String
    
    init(textStatus: Int) {
        switch textStatus {
        case 1:
            backColor = .blue
            stateText = "申请已提交"
        case 2:
            backColor = .green
            stateText = "申请已通过"
        case 3:
            backColor = .red
            stateText = "申请已被拒绝"
        case 4:
            backColor = .orange
            stateText = "已退出申请"
        case 5:
            backColor = .gray
            stateText = "申请已取消"
        default:
            backColor = .black
            stateText = "加油"
        }
    }
    
    var body: some View {
        Text(stateText)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.headline)
            .frame(width: 250)
            .padding(.all, 10)
            .background(backColor)
            .cornerRadius(40)
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(backColor, lineWidth: 5)
            )
            .padding()
    }
}

struct ApplyScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyScheduleView(schedule: testSchedule)
    }
}
