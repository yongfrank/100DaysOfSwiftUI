//
//  SideBarClockLabel.swift
//  TimeTracking
//
//  Created by Frank Chu on 10/22/22.
//

import SwiftUI

struct SideBarClockLabel: View {
    @EnvironmentObject var env: GlobalEnvironment
    @Binding var clock: Clock
    var body: some View {
        Button {
            if self.env.PublicTimer.isValid == false {
                self.env.activateClock(clock: clock)
                
                /// Creates and returns a new NSTimer object initialized with the specified block object and schedules it on the current run loop in the default mode.
                /// `open class func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer`
                /// - parameter:  block  The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
                self.env.PublicTimer =
                    .scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                        self.env.PublicDate = Date()
                    })
            } else {
                if self.env.activeClock != clock {
                    self.env.inactivateClock()
                    self.env.PublicTimer.invalidate()
                    self.env.activateClock(clock: clock)
                    self.env.PublicTimer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                        self.env.PublicDate = Date()
                    })
//                    let publisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    
                } else {
                    self.env.inactivateClock()
                    self.env.PublicTimer.invalidate()
                }
            }
        } label: {
//            HStack(spacing: 0) {
            HStack {
                Image(systemName: "hourglass")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()
                    .foregroundColor(clock.color)
                Spacer().frame(width: 10)
                Text(secondsToFullString(clock.timeSegments.sumAllSegment()))
                    .font(.system(size: 20, weight: .light, design: .monospaced))
                    .frame(height: 30)
                    .padding(.horizontal, 10)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(self.env.activeClock == clock ? clock.color : dGray.opacity(0))
                    )
                Spacer().frame(width: 10)
                Text(clock.name)
            }
        }
        .buttonStyle(PlainButtonStyle())

    }
}

struct SideBarClockLabel_Previews: PreviewProvider {
    static var previews: some View {
        SideBarClockLabel(clock: .constant(.EXAMPLECLOCK))
            .environmentObject(GlobalEnvironment())
//            .preferredColorScheme(.light)
    }
}
