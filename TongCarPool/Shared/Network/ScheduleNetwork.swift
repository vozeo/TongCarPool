//
//  ScheduleNetwork.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/8.
//

import Foundation

var allSheduleList: [Schedule] = [Schedule()]

struct GetAllScheduleReq: Codable {
    var limitDepartTime: Bool = false
    var departTimeFrom: Date?
    var departTimeUntil: Date?
}

struct GetAllShceduleRes: Codable {
    var success: Bool
    var msg: String?
    var data: [Schedule]?
}


struct PostScheduleId: Codable {
    var scheduleId: Int
}

struct PostScheduleRes: Codable {
    var success: Bool
    var msg: String?
    var data: PostScheduleId?
}

@MainActor
func getAllSchedule() async {
    var request = postRequest(subURL: "getPublishedSchedules")
    request.httpBody = try? JSONEncoder().encode(GetAllScheduleReq(limitDepartTime: false, departTimeFrom: nil, departTimeUntil: nil))
    print(String(decoding: request.httpBody ?? Data(), as: UTF8.self))
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            let decoder = JSONDecoder()
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds, .withTimeZone]
            decoder.dateDecodingStrategy = .custom({ decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                if let date = formatter.date(from: dateString) {
                    return date
                }
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
            })
            let userResponse = try decoder.decode(GetAllShceduleRes.self, from: data)
            if userResponse.success {
                allSheduleList = userResponse.data ?? testScheduleList()
                for index in 0 ..< allSheduleList .count {
                    allSheduleList[index].departTime -= 8 * 3600
                    allSheduleList[index].createTime! += 8 * 3600
                }
                print(userResponse)
            }
        }
    } catch {}
}

func postSchedule(schedule: Schedule) async -> Bool {
    var request = postRequest(subURL: "postSchedule")
    request.httpBody = try? JSONEncoder().encode(schedule)
    print(String(decoding: request.httpBody ?? Data(), as: UTF8.self))
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            let userResponse = try JSONDecoder().decode(PostScheduleRes.self, from: data)
            if userResponse.success {
                print(userResponse)
                return true
            }
            return false
        }
        return false
    } catch {
        return false
    }
}

func postSimpleSchedule(schedule: Schedule, subURL: String) async -> Bool {
    var request = postRequest(subURL: subURL)
    let enc = JSONEncoder()
    let sillyFormatter = DateFormatter()
    sillyFormatter.locale = Locale(identifier: "en_US_POSIX")
    sillyFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    enc.dateEncodingStrategy = .formatted(sillyFormatter)
    request.httpBody = try? enc.encode(schedule)
    print(String(decoding: request.httpBody ?? Data(), as: UTF8.self))
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            let userResponse = try JSONDecoder().decode(PostScheduleRes.self, from: data)
            if userResponse.success {
                print(userResponse)
                return true
            }
            return false
        }
        return false
    } catch {
        return false
    }
}
