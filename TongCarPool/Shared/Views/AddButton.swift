//
//  AddButton.swift
//  TongCarPool
//
//  Created by Vozeo on 2022/6/6.
//

import SwiftUI
import SlideOverCard

struct AddButton: View {
    private let circleWidth = CGFloat(60)
    @State private var dragAmount: CGPoint?
    @State private var isShowEdit = false
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                isShowEdit.toggle()
            }, label: {
                ZStack{
                    Circle()
                        .foregroundStyle((LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.pink]), startPoint: .leading, endPoint: .trailing)))
                        .shadow(radius: 5)
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
            })
            .frame(width: circleWidth, height: circleWidth)
            .position(self.dragAmount ?? CGPoint(x: geometry.size.width - circleWidth - 10, y: geometry.size.height - circleWidth - 30))
            .sheet(isPresented: $isShowEdit) {
                EditScheduleView(barTitle: "新建行程", buttonAction: {isShowEdit.toggle()}, schedule: Schedule())

            }
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
