//
//  UserViewContainer.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/6.
//

import SwiftUI

struct UserViewContainer: View {
    var user: User = loginUser
    @Binding var bindGender: Gender
    @Binding var bindWechatid: String
    var genderState: String = ""

    var body: some View {
        VStack{
            HStack(spacing: 0) {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .padding(.trailing, 80)
                VStack(alignment: .leading) {
                    Text(loginUser.username)
                        .font(.system(size: 26, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    Text(genderName[bindGender.description] ?? "3")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    Text(bindWechatid)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.white)
                }
            }
            .frame(width: 360)
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: Double.random(in: 0.3...0.5), green: Double.random(in: 0.3...0.5), blue: Double.random(in: 0.3...0.5)))
        .modifier(ScheduleModifier())
        .padding(.all, 20)
    }
}

struct UserViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        UserViewContainer(bindGender: .constant(.secret), bindWechatid: .constant(""))
    }
}
