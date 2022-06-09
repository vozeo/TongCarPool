//
//  EditScheduleView.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/7.
//

import SwiftUI
import MapItemPicker

struct EditScheduleView: View {
    var barTitle: String
    var buttonAction: () -> Void
    @State var schedule: Schedule
    @State private var isShowFrom = false
    @State private var isShowTo = false
    @State private var isShowAlert = false
    @State private var fromName: String = ""
    @State private var toName: String = ""
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("标题和内容")) {
                    TextField("Title", text: $schedule.title)
                    TextField("Text", text: $schedule.text)
                }
                Section(header: Text("人数")) {
                    TextField("Target Participants", value: $schedule.targetParticipants, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                }
                
                Section(header: Text("行程信息")) {
                    DatePicker("Depart Time", selection: $schedule.departTime, in: Date.now...)
                    Button("Location From " + fromName) {
                        isShowFrom.toggle()
                    }
                    .mapItemPicker(isPresented: $isShowFrom) { item in
                        if let name = item?.name {
                            fromName = name
                            schedule.locFrom.lon = Float(item!.placemark.location!.coordinate.longitude)
                            schedule.locFrom.lat = Float(item!.placemark.location!.coordinate.latitude)
                            print("Selected \(name)")
                        }
                    }
                    if schedule.locFrom.lon != 0 && schedule.locFrom.lat != 0 {
                        HStack {
                            Text("经度 " + String(schedule.locFrom.lon))
                            Spacer()
                            Text("纬度 " + String(schedule.locFrom.lat))
                        }
                    }
                    Button("Location To " + toName) {
                        isShowTo.toggle()
                    }
                    .mapItemPicker(isPresented: $isShowTo) { item in
                        if let name = item?.name {
                            toName = name
                            schedule.locTo.lon = Float(item!.placemark.location!.coordinate.longitude)
                            schedule.locTo.lat = Float(item!.placemark.location!.coordinate.latitude)
                            print("Selected \(name)")
                        }
                    }
                    if schedule.locTo.lon != 0 && schedule.locTo.lat != 0 {
                        HStack {
                            Text("经度 " + String(schedule.locTo.lon))
                            Spacer()
                            Text("纬度 " + String(schedule.locTo.lat))
                        }
                    }
                }
                Section() {
                    Button(action: {
                        schedule.status = 1
                        var isPost: Bool = false
                        let dstURL = (barTitle == "修改行程" ? "modifySchedule" : "postSchedule")
                        Task {
                            isPost = await postSimpleSchedule(schedule: Schedule(scheduleId: schedule.scheduleId, targetParticipants: schedule.targetParticipants, departTime: schedule.departTime, status: schedule.status, title: schedule.title, text: schedule.text, locFrom: schedule.locFrom, locTo: schedule.locTo), subURL: dstURL)
                            if isPost {
                                buttonAction()
                                await getAllSchedule()
                            } else {
                                isShowAlert.toggle()
                            }
                        }
                    }) {
                        Text("OK👌")
                        .font(Font.body.weight(.medium))
                    }
                }
            }
            .navigationBarTitle(barTitle)
        }
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text(barTitle + "错误"),
                  message: Text("请检查行程信息后重试。"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct EditScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleView(barTitle: "编辑行程", buttonAction: {}, schedule: testSchedule)
            .previewInterfaceOrientation(.portrait)
    }
}
