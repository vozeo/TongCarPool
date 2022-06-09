//
//  PersonInformationView.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/5.
//

import SwiftUI

// = loginUser.wechatid ?? ""
// = Gender(rawValue: genderEnum[loginUser.gender ?? "0"] ?? "secret") ?? .secret

struct PersonInformationView: View {
    var buttonAction: () -> Void
    @Binding var wechatid: String
    @Binding var selectGender: Gender
    @State private var isShowAlert = false
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                VStack {
                    Text("Personal Information")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    
                    
                    TextField("Wechat ID", text: $wechatid)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.vertical)
                    
                    VStack {
                        Picker("Flavor", selection: $selectGender) {
                            ForEach(Gender.allCases) { gender in
                                Text(gender.rawValue.capitalized)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Button(action: {
                        var isChanged: Bool = false
                        Task {
                            loginUser.wechatid = wechatid
                            loginUser.gender = selectGender.description
                            isChanged = await userPost(user: loginUser, subURL: "modifyUserInfo")
                            if isChanged {
                                buttonAction()
                            } else {
                                isShowAlert.toggle()
                            }
                        }
                    }, label: {
                        PrimaryButton(title: "Commit")
                            .padding(.vertical)
                    })
            
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
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("用户信息输入错误"),
                  message: Text("请检查用户信息后重试。"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
        
    }
}

struct PersonInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonInformationView(
            buttonAction: {
                if let window = UIApplication.shared.currentUIWindow() {
                    window.rootViewController = UIHostingController(rootView: RootViewContainer())
                    window.makeKeyAndVisible()
                }
            }, wechatid: .constant(""), selectGender: .constant(.secret)
        )
    }
}
