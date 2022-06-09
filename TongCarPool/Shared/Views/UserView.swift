//
//  UserView.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/2.
//

import SwiftUI

struct UserView: View {
    @State private var isShowView = false
    @State private var isShowChange = false
    @State private var wechatid: String = loginUser.wechatid ?? ""
    @State private var gender: Gender = Gender(rawValue: genderEnum[loginUser.gender ?? "0"] ?? "secret") ?? .secret
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                UserViewContainer(bindGender: $gender, bindWechatid: $wechatid)
                    .frame(width: 400, height: 400)
                Button(action: {
                    isShowView.toggle()
                }) {
                    Text("Change Information")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.headline)
                        .frame(width: 300)
                        .padding(.all, 10)
                        .background(.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(.all, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(.red, lineWidth: 5)
                        )
                        .padding()
                }
                Button(action: {
                    isShowChange.toggle()
                }) {
                    Text("Change Password")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.headline)
                        .frame(width: 300)
                        .padding(.all, 10)
                        .background(.red)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(.all, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(.blue, lineWidth: 5)
                        )
                        .padding()
                }

            }
            .navigationBarTitle("", displayMode: .large)
                .toolbar {
                    ToolbarItemGroup(placement: .navigation) {
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 25, height: 25)
                            Text(loginUser.username)
                                .font(Font.system(size: 20, weight: .bold))
                                .padding()
                                .frame(width: UIScreen.main.bounds.size.width / 2, alignment: .leading)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                        }) {
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.trailing, 10)
                        }
                    }
                }
                .sheet(isPresented: $isShowView) {
                    PersonInformationView(buttonAction: {isShowView.toggle()}, wechatid: $wechatid, selectGender: $gender)
                }
                .sheet(isPresented: $isShowChange) {
                    ChangePasswordView(buttonAction: {isShowChange.toggle()})
                }
        }

    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
