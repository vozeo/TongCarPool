//
//  ApplyScheduleViewContainer.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/6.
//

import SwiftUI
import SlideOverCard

struct ApplyScheduleViewContainer: View {
    @State private var isShowSheet = false
    @State private var isShowAlert = false
    @State private var showSchedule: Schedule = Schedule()
    var body: some View {
        NavigationView{
            List {
                ForEach(allSheduleList, id: \.scheduleId) { (schedule) in
                    if (schedule.creator != loginUser.userid) {
                        Button(action: {
                            isShowSheet.toggle()
                            showSchedule = schedule
                            showSchedule.status = Int.random(in: 1...5)
                        }) {
                            ApplyScheduleView(schedule: schedule)
                        }
                    }
                }
            }
            .navigationTitle("我申请的")
        }
        .slideOverCard(isPresented: $isShowSheet, options: [.hideExitButton]) {
            ScheduleDetailView(initSchedule: showSchedule)
            VStack(spacing: 0) {
                Button("变更申请", action: {
                    isShowSheet.toggle()
                    isShowAlert.toggle()
                })
                .buttonStyle(SOCActionButton())
                .padding(.bottom, 30)
                
                Button("退出", action: {
                    isShowSheet.toggle()
                }).buttonStyle(SOCEmptyButton())
                .padding(.bottom, 100)
            }
        }
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("变更申请已发送"),
                  message: Text("请耐心等待回复，可在我的申请界面中查看。"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct ApplyScheduleViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        ApplyScheduleViewContainer()
    }
}
