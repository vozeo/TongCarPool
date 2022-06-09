//
//  UserApplyViewContainer.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/7.
//

import SwiftUI

struct UserApplyViewContainer: View {
    @State var inUserList: [User]
    var acceptAction: () -> Void
    var rejectAction: () -> Void
    var body: some View {
        NavigationView {
        List {
            ForEach(inUserList, id: \.username) { (user) in
                VStack {
                    HStack(alignment: .center) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text(user.username)
                                .font(.system(size: 26, weight: .bold, design: .default))
                                .foregroundColor(.white)
                            Text(genderName[user.gender ?? "4"] ?? "")
                                .font(.system(size: 16, weight: .bold, design: .default))
                                .foregroundColor(.white)
                            Text(user.wechatid ?? "")
                                .font(.system(size: 16, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 20)
                    }
                    HStack {
                        Spacer()
                        Button(action: acceptAction) {
                            Text("同意请求")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.headline)
                                .padding(.all, 10)
                                .padding(.horizontal, 10)
                                .background(.green)
                                .cornerRadius(40)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                        Button(action: rejectAction) {
                            Text("拒绝请求")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.headline)
                                .padding(.all, 10)
                                .padding(.horizontal, 10)
                                .background(.red)
                                .cornerRadius(40)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color(red: Double.random(in: 0.3...0.5), green: Double.random(in: 0.3...0.5), blue: Double.random(in: 0.3...0.5)))
                .modifier(ScheduleModifier())
                .padding(.all, 10)
            }
        }.navigationBarTitle("申请人")
        }
    }
}

struct UserApplyViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        UserApplyViewContainer(inUserList: generateUserList(), acceptAction: {}, rejectAction: {})
    }
}
