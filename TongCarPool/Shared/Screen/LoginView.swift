//
//  LoginView.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/2.
//

import SwiftUI

struct LoginView: View {
    @State private var isShowAlert = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var wechatid: String = ""
    @State private var gender: Gender = .secret
    @State private var loggedIn: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    
                    VStack {
                    
                        Text("Sign Up / Sign In")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 30)
                 
                        TextField("Username", text: $username)
                            .font(.title3)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                            .padding(.vertical)
                            
                        SecureField("Password", text: $password)
                            .font(.title3)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                            .padding(.bottom)
                    
                        NavigationLink(
                            destination: PersonInformationView(buttonAction: {
                                if let window = UIApplication.shared.currentUIWindow() {
                                    window.rootViewController = UIHostingController(rootView: RootViewContainer())
                                    window.makeKeyAndVisible()
                                }
                            }, wechatid: $wechatid, selectGender: $gender)
                            .navigationBarHidden(true), isActive: $loggedIn) {
                                Button(action: {
                                    var isLogin: Bool = false
                                    var isRegister: Bool = false
                                    let inputUser = User(username: username, password: String(password.MD5 + username.MD5).MD5)
                                    print(String(password.MD5 + username.MD5).MD5)
                                    Task {
                                        isLogin = await userPost(user: inputUser, subURL: "login")
                                        if (!isLogin) {
                                            isRegister = await userPost(user: inputUser, subURL: "register")
                                        }
                                        if isLogin || isRegister {
                                            if (loginUser.gender != nil) {
                                                if let window = UIApplication.shared.currentUIWindow() {
                                                    await getAllSchedule()
                                                    window.rootViewController = UIHostingController(rootView: RootViewContainer())
                                                    window.makeKeyAndVisible()
                                                }
                                            } else {
                                                isLogin = await userPost(user: inputUser, subURL: "login")
                                                if (isLogin) {
                                                    await getAllSchedule()
                                                    loggedIn.toggle()
                                                } else {
                                                    isShowAlert.toggle()
                                                }
                                            }
                                        } else {
                                            isShowAlert.toggle()
                                        }
                                    }
                                }) {
                                    PrimaryButton(title: "Sign Up / Sign In")
                                        .padding(.vertical)
                                }
                            }
                            .navigationBarHidden(true)
                
                    }
                    
                    Spacer()
                    Divider()
                    Spacer()
                    Text("Welcome to TongCarPool")
                    Text("Read our Terms & Conditions.")
                        .foregroundColor(Color("PrimaryColor"))
                    Spacer()
                    
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("登录错误"),
                  message: Text("请检查账号或密码后重试。"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
