//
//  RootViewContainer.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/2.
//

import SwiftUI

struct RootViewContainer: View {
    @State private var selectedView = 0
    var body: some View {
        ZStack {
            TabView(selection: $selectedView) {
                ScheduleViewContainer()
                    .tabItem {
                        selectedView == 0 ?
                            Image(systemName: "house.fill") : Image(systemName: "house")
                        Text("所有行程")
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .tag(0)
                MyScheduleViewContainer()
                    .tabItem {
                        selectedView == 1 ? Image(systemName: "film.fill") : Image(systemName: "film")
                        Text("我发布的")
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .tag(1)
                ApplyScheduleViewContainer()
                    .tabItem {
                        selectedView == 2 ? Image(systemName: "heart.fill") : Image(systemName: "heart")
                        Text("我申请的")
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .tag(2)
                UserView()
                    .tabItem {
                        selectedView == 3 ? Image(systemName: "person.circle.fill") : Image(systemName: "person.circle")
                        Text("个人信息")
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .tag(3)
            }
            .font(.headline)
            AddButton()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct RootViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        RootViewContainer()
    }
}
