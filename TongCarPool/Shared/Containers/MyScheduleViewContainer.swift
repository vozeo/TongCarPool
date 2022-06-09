//
//  MyScheduleViewContainer.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/6.
//

import SwiftUI
import SlideOverCard

struct MyScheduleViewContainer: View {
    @State private var isShowSheet = false
    @State private var isShowAlert = false
    @State private var isShowChange = false
    @State private var isShowApply = false
    @State private var showSchedule: Schedule = Schedule()
    var body: some View {
        NavigationView{
            List {
                ForEach(allSheduleList, id: \.scheduleId) { (schedule) in
                    if (schedule.creator == loginUser.userid) {
                        Button(action: {
                            isShowSheet.toggle()
                            showSchedule = schedule
                        }) {
                            ScheduleView(schedule: schedule)
                        }
                    }
                }
            }
            .navigationTitle("我发布的")
        }
        .slideOverCard(isPresented: $isShowSheet, options: [.hideExitButton]) {
            ScheduleDetailView(initSchedule: showSchedule)
            VStack(spacing: 0) {
                Button("修改行程", action: {
                    isShowChange.toggle()
                }).buttonStyle(SOCActionButton())
                    .padding(.bottom, 30)
                Button("查看申请人", action: {
                    isShowApply.toggle()
                }).buttonStyle(SOCActionButton())
                    .padding(.bottom, 100)
            }
        }
        .sheet(isPresented: $isShowChange) {
            EditScheduleView(barTitle: "修改行程", buttonAction: {isShowChange.toggle()}, schedule: showSchedule)
        }
        .sheet(isPresented: $isShowApply) {
            UserApplyViewContainer(inUserList: generateUserList(), acceptAction: {isShowApply.toggle()}, rejectAction: {isShowApply.toggle()})
        }
        
    }
}

struct MyScheduleViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        MyScheduleViewContainer()
    }
}
