//
//  ContentView.swift
//  Animations
//
//  Created by Frank Chu on 3/12/22.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var animationAmount = 2.0
    @State private var ringRadius = 1.0
    
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    @State private var isShowingRed = false

    
    var body: some View {
        TabView {
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)

                if isShowingRed {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
            .onTapGesture {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            .tabItem {
                Label("Fourth", systemImage: "4.circle")
            }
            
            VStack {
                Button("Tap Me") {
                    // do nothing
                    withAnimation {
                        isShowingRed.toggle()
                    }
                    

                    
                }
                if isShowingRed {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
//                        .transition(.scale)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))

                }
                
//                Spacer()
                
                HStack(spacing: 0) {
                            ForEach(0..<letters.count) { num in
                                Text(String(letters[num]))
                                    .padding(5)
                                    .font(.title)
                                    .background(enabled ? .blue : .red)
                                    .offset(dragAmount)
                                    .animation(.default.delay(Double(num) / 20), value: dragAmount)
                            }
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { dragAmount = $0.translation }
                                .onEnded { _ in
                                    dragAmount = .zero
                                    enabled.toggle()
                                }
                        )
                
                LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .frame(width: 300, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .offset(dragAmount)
                            .gesture(
                                DragGesture()
                                    .onChanged { dragAmount = $0.translation }
//                                    .onEnded { _ in dragAmount = .zero }
                                    .onEnded { _ in
                                        withAnimation(.spring()) {
                                            dragAmount = .zero
                                        }
                                    }
                            )
//                            .animation(.spring(), value: dragAmount)
                


            }
            .tabItem {
                Label("Third", systemImage: "3.circle")
            }
            
            
            VStack {
                Button("Tap Me") {
                    // do nothing
                    enabled.toggle()

                }
//                .animation(nil, value: enabled)
                .frame(width: 200, height: 200)
//                .background(.blue)
                .foregroundColor(.white)
                .background(enabled ? .blue : .red)
//                .animation(.default, value: enabled)
                .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 120))
                .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)

            }
            .tabItem {
//                Label("Order", systemImage: "square.and.pencil")
                Label("Second", systemImage: "2.circle")
            }
            
            
            VStack {
                VStack {
                    Stepper("Scale amount", value: $animationAmount.animation(
                        .easeInOut(duration: 1)
                            .repeatCount(3, autoreverses: true)
                    ), in: 1...10)

                    Spacer()

                    Button("Tap Me") {
                        animationAmount += 1
                    }
                    .padding(40)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .scaleEffect(animationAmount)
                    
                    
                    Spacer()
                }
                Button("Tap Me") {
                    withAnimation {
                        animationAmount += 360
                    }
                }
                .padding(50)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                
                Spacer()
                
                Stepper("Ring Radius", value: $ringRadius)
                
                Button("Tap Me") {
                    ringRadius += 1
                }
                .padding(50)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(Circle())
        //        .scaleEffect(animationAmount)
                .overlay(
                    Circle()
                        .stroke(.blue)
                        .scaleEffect(ringRadius)
                        .opacity(2 - ringRadius)
                        .animation(
                            .easeInOut(duration: 1)
                                .repeatForever(autoreverses: false),
                            value: ringRadius
                        )
                )
                .onAppear {
                    ringRadius = 2
                }
            }
            .tabItem {
//                Label("Home", systemImage: "list.dash")
                Label("First", systemImage: "1.circle")
            }
            
            
    
            
        }
        
//        .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
//        .blur(radius: (animationAmount - 1) * 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
