//
//  Schedule.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/1.
//

import Foundation

struct LocFrom: Codable {
    var lon: Float = 0
    var lat: Float = 0
    init() {
        lon = Float.random(in: 0...90)
        lat = Float.random(in: 0...90)
    }
}

struct LocTo: Codable {
    var lon: Float = 0
    var lat: Float = 0
    init() {
        lon = Float.random(in: 0...90)
        lat = Float.random(in: 0...90)
    }
}

struct Schedule: Codable {
    var scheduleId: Int = 0
    var creator: Int? = 0
    var targetParticipants: Int = 0
    var currentParticipants: Int? = 1
    var createTime: Date? = Date.now
    var departTime: Date = Date.now
    var status: Int = 1
    var title: String = ""
    var text: String = ""
    var locFrom: LocFrom = LocFrom()
    var locTo: LocTo = LocTo()
}

let testSchedule = Schedule(scheduleId: 1, creator: 1, targetParticipants: 5, currentParticipants: 3, createTime: Date(), departTime: Date(), status: Int.random(in: 1...5), title: "从嘉定到四平", text: "今天也是要去看樱花的一天呢", locFrom: LocFrom(), locTo: LocTo())

func testScheduleList() -> [Schedule] {
    var list: [Schedule] = []
    for i in 1...15 {
        list.append(Schedule(scheduleId: i, creator: 1, targetParticipants: Int.random(in: 4...7), currentParticipants: Int.random(in: 1...3), createTime: Date(), departTime: Date(), status: Int.random(in: 1...5), title: "从嘉定到四平", text: "今天也是要去看樱花的一天呢", locFrom: LocFrom(), locTo: LocTo()))
    }
    return list
}
