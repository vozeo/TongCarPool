//
//  ChangePasswordView.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/5.
//

import SwiftUI

struct ChangePasswordView: View {
    var buttonAction: () -> Void
    @State private var newPassword: String = ""
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                VStack(spacing: 30) {
                
                    Text("Change Password")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                        
                    SecureField("New Password", text: $newPassword)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        .padding(.bottom)
                
                    Button(action: buttonAction, label: {
                        PrimaryButton(title: "Change Password")
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
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(buttonAction: {})
    }
}
