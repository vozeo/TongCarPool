//
//  ScheduleDetailView.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/6.
//

import SwiftUI
import MapKit
import SlideOverCard

struct ScheduleDetailView: View {
    var schedule: Schedule
    @State private var fromRegion: MKCoordinateRegion
    @State private var toRegion: MKCoordinateRegion
    @State private var isShowFromSheet = false
    @State private var isShowToSheet = false
    init(initSchedule: Schedule) {
        schedule = initSchedule
        _fromRegion = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(schedule.locFrom.lat), longitude: Double(schedule.locFrom.lon)), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
        _toRegion = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(schedule.locTo.lat), longitude: Double(schedule.locTo.lon)), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
    }
    var body: some View {
        VStack {
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
                        Text(String.init(format: "Waiting %d of %d people", schedule.targetParticipants - schedule.currentParticipants!, schedule.targetParticipants))
                            .font(.system(size: 16, weight: .bold, design: .default))
                            .foregroundColor(.white)
                    }
                }.padding(.trailing, 20)
            }
            HStack {
                Spacer()
                Button(action: {
                    isShowFromSheet.toggle()
                }) {
                    Text("From")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 5)
                        .frame(width: 100)
                        .background(.orange)
                        .cornerRadius(40)
                }
                Spacer()
                Button(action: {
                    isShowToSheet.toggle()
                }) {
                    Text("To")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 5)
                        .frame(width: 100)
                        .background(.yellow)
                        .cornerRadius(40)
                }
                Spacer()
            }.padding(.top, -10)
            Text("创建时间：" + dateToString(schedule.createTime!))
                .padding(.vertical, 5)
            Text(schedule.text)
                .font(.system(size: 26, weight: .bold, design: .default))
                .foregroundColor(.white)
                .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: Double.random(in: 0.3...0.5), green: Double.random(in: 0.3...0.5), blue: Double.random(in: 0.3...0.5)))
        .modifier(ScheduleModifier())
        .padding(.all, 10)
        .sheet(isPresented: $isShowFromSheet) {
            ZStack {
                Map(coordinateRegion: $fromRegion, showsUserLocation: false, userTrackingMode: .constant(.follow))
                Button(action: {isShowFromSheet.toggle()}) {
                    Text("Exit")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 5)
                        .frame(width: 100, height: 50)
                        .background(.red)
                        .cornerRadius(40)
                }
                .padding(.top, 600)
            }
        }
        .sheet(isPresented: $isShowToSheet) {
            ZStack {
                Map(coordinateRegion: $toRegion, showsUserLocation: false, userTrackingMode: .constant(.follow))
                Button(action: {isShowToSheet.toggle()}) {
                    Text("Exit")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 5)
                        .frame(width: 100, height: 50)
                        .background(.red)
                        .cornerRadius(40)
                }
                .padding(.top, 600)
            }
        }
    }
}

struct ScheduleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleDetailView(initSchedule: testSchedule)
    }
}
