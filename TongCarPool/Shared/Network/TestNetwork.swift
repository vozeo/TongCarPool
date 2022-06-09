//
//  TestNetwork.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/9.
//

import SwiftUI

let str:String = """
{"data":[{"creator":13,"departTime":"2022-06-11T11:20:00.000+00:00","createTime":"2022-06-09T19:20:12.000+00:00","locFrom":{"lon":121.21415710449219,"lat":31.286012649536133},"currentParticipants":1,"text":"今天也是要去看樱花的一天呢","title":"从嘉定到四平","scheduleId":59,"locTo":{"lon":121.5014877319336,"lat":31.282939910888672},"targetParticipants":5,"status":1},{"creator":13,"departTime":"2022-06-11T05:22:00.000+00:00","createTime":"2022-06-09T21:22:58.000+00:00","currentParticipants":1,"text":"常回家看看","title":"从嘉定到浦东","scheduleId":60,"targetParticipants":5,"status":1},{"creator":13,"departTime":"2022-06-12T13:26:00.000+00:00","createTime":"2022-06-09T21:27:18.000+00:00","locFrom":{"lon":121.21415710449219,"lat":31.286012649536133},"currentParticipants":1,"text":"今天也是要去看樱花的一天呢","title":"从嘉定到四平","scheduleId":61,"locTo":{"lon":121.5014877319336,"lat":31.282939910888672},"targetParticipants":6,"status":1},{"creator":13,"departTime":"2022-06-13T14:25:00.000+00:00","createTime":"2022-06-09T22:25:33.000+00:00","locFrom":{"lon":121.5014877319336,"lat":31.282939910888672},"currentParticipants":1,"text":"今天也是要去看樱花的一天呢","title":"从嘉定到四平","scheduleId":62,"locTo":{"lon":121.21415710449219,"lat":31.286012649536133},"targetParticipants":5,"status":1},{"creator":13,"departTime":"2022-06-12T14:31:00.000+00:00","createTime":"2022-06-09T22:31:25.000+00:00","locFrom":{"lon":100.97234344482422,"lat":22.777320861816406},"currentParticipants":1,"text":"今天也是要去看樱花的一天呢","title":"从嘉定到四平","scheduleId":63,"locTo":{"lon":130.36163330078125,"lat":46.80960464477539},"targetParticipants":5,"status":1},{"creator":13,"departTime":"2022-06-12T16:18:00.000+00:00","createTime":"2022-06-10T00:20:12.000+00:00","locFrom":{"lon":121.21415710449219,"lat":31.286012649536133},"currentParticipants":1,"text":"I can go home","title":"Go to airplay","scheduleId":64,"locTo":{"lon":121.33978271484375,"lat":31.196056365966797},"targetParticipants":4,"status":1},{"creator":20,"departTime":"2022-06-11T00:12:41.000+00:00","createTime":"2022-06-10T00:52:58.000+00:00","locFrom":{"lon":2,"lat":3},"currentParticipants":1,"text":"和cxx一起哦","title":"出去玩","scheduleId":65,"locTo":{"lon":4,"lat":2},"targetParticipants":5,"status":1},{"creator":13,"departTime":"2022-06-12T13:25:00.000+00:00","createTime":"2022-06-10T05:26:12.000+00:00","locFrom":{"lon":121.21415710449219,"lat":31.286012649536133},"currentParticipants":1,"text":"回家啦","title":"从嘉定到虹桥机场","scheduleId":66,"locTo":{"lon":121.33978271484375,"lat":31.196056365966797},"targetParticipants":4,"status":1},{"creator":19,"departTime":"2022-06-12T13:52:00.000+00:00","createTime":"2022-06-10T05:52:29.000+00:00","locFrom":{"lon":121.47264099121094,"lat":31.231706619262695},"currentParticipants":1,"text":"常回家看看","title":"从上海到北京","scheduleId":67,"locTo":{"lon":116.40528869628906,"lat":39.90498733520508},"targetParticipants":4,"status":1},{"creator":13,"departTime":"2022-06-20T14:39:00.000+00:00","createTime":"2022-06-10T06:39:09.000+00:00","locFrom":{"lon":50.65084457397461,"lat":75.04400634765625},"currentParticipants":1,"text":"解析不成功了","title":"呜呜呜","scheduleId":68,"locTo":{"lon":24.310148239135742,"lat":53.41234588623047},"targetParticipants":4,"status":1}],"success":true,"msg":null}
"""

@MainActor
func testGetAllSchedule() async {
    do {
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
        let userResponse = try decoder.decode(GetAllShceduleRes.self, from: Data(str.utf8))
        if userResponse.success {
            allSheduleList = userResponse.data ?? testScheduleList()
            for index in 0 ..< allSheduleList .count {
                allSheduleList[index].departTime -= 8 * 3600
                allSheduleList[index].createTime! += 8 * 3600
            }
            print(userResponse)
        }
    } catch { print(error) }
}

struct TestNetwork: View {
    var body: some View {
        Button(action: {
//            let dateFormatter = ISO8601DateFormatter()
//            dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
//            //let date = dateFormatter.date(from: "2022-06-11T13:22:00.000+00:00")
//
//            let formatter = DateFormatter()
//            // formatter.locale = Locale(identifier: "en_US_POSIX")
//            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//            let date = formatter.date(from: "2022-06-11T13:22:00.000+00:00")
            Task {
                await testGetAllSchedule()
            }
            print("tt")
        }) {
            Text("test")
        }
    }
}

struct TestNetwork_Previews: PreviewProvider {
    static var previews: some View {
        TestNetwork()
    }
}
