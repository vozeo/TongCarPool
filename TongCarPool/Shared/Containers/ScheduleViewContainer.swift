//
//  ScheduleView.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/2.
//

import SwiftUI
import SlideOverCard

struct ScheduleViewContainer: View {
    @State private var isShowSheet = false
    @State private var isShowAlert = false
    @State private var showSchedule: Schedule = Schedule()
    var scheduleList: [Schedule] = allSheduleList
    var body: some View {
        NavigationView{
            List {
                ForEach(scheduleList, id: \.scheduleId) { (schedule) in
                    ZStack {
                        Button(action: {
                            isShowSheet.toggle()
                            showSchedule = schedule
                        }) {
                            ScheduleView(schedule: schedule)
                        }
                    }
                }
            }
            .navigationTitle("所有行程")
        }
        .slideOverCard(isPresented: $isShowSheet, options: [.hideExitButton])  {
            ScheduleDetailView(initSchedule: showSchedule)
            VStack(spacing: 0) {
                Button("发起组队请求", action: {
                    isShowSheet.toggle()
                    isShowAlert.toggle()
                })
                .buttonStyle(SOCActionButton())
                .padding(.bottom, 30)
                
                Button("我就看看", action: {
                    isShowSheet.toggle()
                })
                .buttonStyle(SOCEmptyButton())
                .padding(.bottom, 100)
            }
        }
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("组队请求已发送"),
                  message: Text("请耐心等待回复，可在我的申请界面中查看。"),
                  dismissButton: .default(Text("OK")))
        }
    }

}

struct ScheduleViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleViewContainer()
    }
}
