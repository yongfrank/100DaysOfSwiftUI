//
//  CardView.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/20/22.
//

import SwiftUI

extension Shape {
    func fillExtend(by offset: CGSize) -> some View{
        if offset.width == 0 {
            return self.fill(.yellow)
        } else if offset.width < 0 {
            return self.fill(.red)
        } else {
            return self.fill(.green)
        }
    }
}

struct CardView: View {
    
    let card: Card
    var removal: ((Bool) -> Void)? = nil
    
    @State var isShowingAnswer = false
    
    @State var offset = CGSize.zero

    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    @State var feedback = UINotificationFeedbackGenerator()
    
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled

    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
            
                .fill(
                    differentiateWithoutColor
                        ? .yellow
                        : .yellow
                            .opacity(1 - Double(abs(offset.width / 50)))
                )
//                .fill(.white)
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
//                            .fill(offset.width >= 0 ? .green : .red)
                        .fillExtend(by: offset)
                )
                .shadow(radius: 10)
            
            VStack {
                
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }

                }
                
            }
            .padding(20)
            .multilineTextAlignment(.center)
            
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width, y: 0)
        .opacity(3 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    offset = gesture.translation
                    feedback.prepare()
                })
                .onEnded({ _ in
                    
                    if abs(offset.width) > 100 {
                        // remove the card
                        if offset.width > 0 {
    //                        feedback.notificationOccurred(.success)
                            removal?(false)
                        } else {
                            feedback.notificationOccurred(.error)
                            removal?(true)
                            offset = .zero
                        }
//                        removal?()
                    } else {
                        offset = .zero
                    }
                })
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewDevice("iPhone 13 Pro")
            .previewInterfaceOrientation(.landscapeRight)
    }
}
