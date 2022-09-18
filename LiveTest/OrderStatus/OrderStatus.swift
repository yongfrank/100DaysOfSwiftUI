//
//  OrderStatus.swift
//  OrderStatus
//
//  Created by Frank Chu on 9/17/22.
//  https://youtu.be/mBAgCZJr6jw
//  iOS 16 Beta 4 Lock Screen Live Activities API - Xcode 14 - SwiftUI
//  https://youtu.be/gEWvV-TmjqE
//  Dynamic Island API - iOS 16.1 Beta - Xcode 14.1 - SwiftUI Tutorials


import WidgetKit
import SwiftUI
import Intents



//struct Provider: IntentTimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
//    }
//
//    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), configuration: configuration)
//        completion(entry)
//    }
//
//    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let configuration: ConfigurationIntent
//}
//
//struct OrderStatusEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        Text(entry.date, style: .time)
//    }
//}
//
//@main
//struct OrderStatus: Widget {
//    let kind: String = "OrderStatus"
//
//    var body: some WidgetConfiguration {
//        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
//            OrderStatusEntryView(entry: entry)
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
//    }
//}
//
//struct OrderStatus_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderStatusEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}

struct OrderStatusThings {
    var orderType: String
    var orderNumber: String
    var activityString: String
    var detailedDescrbing: String
    
    static let orderReceived: OrderStatusThings = .init(orderType: "Delivery", orderNumber: "2 items", activityString: "Order received", detailedDescrbing: "We just received your order.")
    static let inProgress: OrderStatusThings = .init(orderType: "Delivery", orderNumber: "2 items", activityString: "Order in progress", detailedDescrbing: "We are handcrafting your order.")
    static let orderReady: OrderStatusThings = .init(orderType: "Delivery", orderNumber: "2 items", activityString: "Order ready", detailedDescrbing: "We crafted your order.")
}

//struct OrderStatus_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderStatus()
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}


@main
struct OrderStatus: Widget {
    //    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //    @State var stopwatch = 0
    
    var body: some WidgetConfiguration {
        // MARK: New Activity Configuration with Dynamic Island
        ActivityConfiguration(for: OrderAttributes.self) { context in
            // MARK: Live Activity View
            
            // NOTE: Live Activity Max Height = 220 pixels
            ZStack {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color(AssetsThings.green.rawValue).gradient)
                
                // MARK: Order Status UI
                VStack(alignment: .leading) {
                    // HStack for Icon and Delivery
                    HStack {
                        Image(AssetsThings.iconLogo.rawValue)
                            .resizable()
                        //                            .aspectRatio(contentMode: .fit)
                            .scaledToFit()
                            .frame(width: 50)
                        
                        Text(OrderStatusThings.inProgress.orderType)
                            .foregroundColor(.white.opacity(0.6))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Countdown Timer
                        Text(timerInterval: Date.now...Date(timeInterval: 12 * 60, since: .now), countsDown: true)
                            .monospacedDigit()
                            .font(.caption2)
                        
                        HStack(spacing: -2) {
                            ForEach([AssetsThings.burger, AssetsThings.shake], id: \.self) { image in
                                Image(image.rawValue)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .background {
                                        Circle()
                                            .fill(Color("Green"))
                                            .padding(-2)
                                    }
                                    .background {
                                        Circle()
                                            .stroke(.white, lineWidth: 1.5)
                                            .padding(-2)
                                    }
                            }
                        }
                        .padding(.trailing)
                    }
                    
                    // HStack for Order Received and We Just Received your order
                    HStack(alignment: .bottom, spacing: 0) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(message(status: context.state.status))
                                .font(.title3)
                                .foregroundColor(.white)
                            
                            Text(subMessage(status: context.state.status))
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        // Pull Order received and details description words down
                        .offset(y: 13)
                        
                        
                        HStack(alignment: .bottom) {
                            ForEach(Status.allCases, id: \.self) { type in
                                Image(systemName: type.rawValue)
                                    .font(context.state.status == type ? .title2 : .body)
                                    .foregroundColor(context.state.status == type ? Color("Green") : .white.opacity(0.7))
                                    .frame(width: context.state.status == type ? 45 : 32, height: context.state.status == type ? 45 : 32)
                                    .background {
                                        Circle()
                                            .fill(context.state.status == type ? .white : .green.opacity(0.5))
                                    }
                                // MARK: Bottom Arrow To Look Like Bubble
                                    .background(alignment: .bottom, content: {
                                        BottomArrow(status: context.state.status, type: type)
                                    })
                                    .frame(maxWidth: .infinity)
                                
                            }
                        }
                        // White Bar Connect Three White Point
                        .overlay(alignment: .bottom, content: {
                            // Image Size = 45 + Trailing Padding = 10
                            // 55 / 2 = 27.5
                            Rectangle()
                                .fill(.white.opacity(0.6))
                                .frame(height: 2)
                                .offset(y: 12)
                                .padding(.horizontal, 27.5)
                        })
                        .padding(.leading, 15)
                        //                        .padding(.trailing, -10)
                        .frame(maxHeight: .infinity)
                    }
                    .frame(maxWidth: .infinity, alignment: .bottom)
                    // Padding for Order Received Texts and Three Order Status Image
                    .padding(.bottom, 10)
                }
                // Four Edge of Whole Widget
                .padding(15)
            }
        } dynamicIsland: { context in
            // MARK: Implementing Dynamic Island
            // MARK: Since Live Activites and Dynamic Island Shares Same Data
            DynamicIsland {
                // MARK: Expanded When Long Pressed
                // MARK: Expanded Region can be classified into Four Types
                // Leading, Trailing, Center, Bottom
                
                DynamicIslandExpandedRegion(.leading, priority: 1) {
                    HStack {
                        Image(AssetsThings.iconLogo.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        //                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        Text(OrderStatusThings.inProgress.orderType)
                        //                        Text("Store Pickup")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    //                    Label(OrderStatusThings.inProgress.orderNumber, systemImage: "bag")
                    //                        .foregroundColor(.indigo)
                    //                        .font(.caption2)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    
                    HStack(spacing: -2) {
                        VStack(alignment: .center) {
                            Image(systemName: "timer")
                            Text(timerInterval: Date.now...Date(timeInterval: 12 * 60, since: .now), countsDown: true)
                                .multilineTextAlignment(.center)
                                .monospacedDigit()
                                .font(.caption2)
                        }
                        .padding(.trailing, 5)
                        
                        ForEach([AssetsThings.burger, AssetsThings.shake], id: \.self) { image in
                            Image(image.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .background {
                                    Circle()
                                        .fill(Color("Green"))
                                        .padding(-2)
                                }
                                .background {
                                    Circle()
                                        .stroke(.white, lineWidth: 1.5)
                                        .padding(-2)
                                }
                        }
                        .offset(x: 15)
                    }
                    .padding(.trailing)
                    
                    //                    Label {
                    //                        Text(timerInterval: Date.now...Date(timeInterval: 12 * 60, since: .now), countsDown: true)
                    //                    } icon: {
                    //                        Image(systemName: "timer")
                    //                            .foregroundColor(.indigo)
                    //                    }
                    //                    .font(.title2)
                }
                
                DynamicIslandExpandedRegion(.center) {
                    // This App Don't Require Any Content on Center
                    // But You Can use it in your App
                    
//                                        Text("Driver: Andy Durant is on their way!")
//                                            .lineLimit(1)
//                                            .font(.caption)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        DynamicIslandStatusView(context: context)
//                        Text("Driver: Andy Durant is on their way!")
//                            .lineLimit(1)
//                            .font(.caption)
                        
                        Button {
                            // Deep link into your app.
                        } label: {
                            Label("Call driver", systemImage: "phone")
                        }
                        .foregroundColor(.indigo)
                        .offset(y: 5)
                    }
                }
            } compactLeading: {
                Label {
                    Text(OrderStatusThings.inProgress.orderNumber)
                } icon: {
                    HStack(spacing: 0) {
                        Image(AssetsThings.iconLogo.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(4)
                            .offset(x: -4)
                        Image(systemName: "bag")
                            .foregroundColor(.indigo)
                    }
                }
                .font(.caption2)
                //                HStack {
                //                                        Image(AssetsThings.iconLogo.rawValue)
                //                                            .resizable()
                //                                            .aspectRatio(contentMode: .fit)
                //                                            .padding(4)
                //                                            .offset(x: -4)
                //                                            No In the Video
                //                                            .frame(width: 30)
                //
                //                }
            } compactTrailing: {
                HStack(spacing: 0) {
                    VStack(alignment: .center) {
                        Image(systemName: "timer")
                        Text(timerInterval: Date.now...Date(timeInterval: 12 * 60, since: .now), countsDown: true)
                            .multilineTextAlignment(.center)
                            .monospacedDigit()
                            .font(.caption2)
                    }
                    .frame(maxWidth: 50)
                    Image(systemName: context.state.status.rawValue)
                        .font(.title3)
                    
                }
                
                
            } minimal: {
                // MARK: Minimal Will be only visible when Multiple Activities are there
                Image(systemName: context.state.status.rawValue)
                    .font(.title3)
                //                HStack {
                //                    VStack(alignment: .center) {
                //                        Image(systemName: "timer")
                //                        Text(timerInterval: Date.now...Date(timeInterval: 12 * 60, since: .now), countsDown: true)
                //                            .multilineTextAlignment(.center)
                //                            .monospacedDigit()
                //                            .font(.caption2)
                //                    }
                //                 }
            }
        }
    }
    
    @ViewBuilder
    func DynamicIslandStatusView(context: ActivityViewContext<OrderAttributes>) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text(message(status: context.state.status))
                    .font(.callout)
                    .foregroundColor(.white)
                
                Text(subMessage(status: context.state.status))
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            // Pull Order received and details description words down
            .offset(x: 5, y: 5)
            
            
            HStack(alignment: .bottom) {
                ForEach(Status.allCases, id: \.self) { type in
                    Image(systemName: type.rawValue)
                        .font(context.state.status == type ? .title2 : .body)
                        .foregroundColor(context.state.status == type ? Color("Green") : .white.opacity(0.7))
                        .frame(width: context.state.status == type ? 35 : 26, height: context.state.status == type ? 35 : 26)
                        .background {
                            Circle()
                                .fill(context.state.status == type ? .white : .green.opacity(0.5))
                        }
                    // MARK: Bottom Arrow To Look Like Bubble
                        .background(alignment: .bottom, content: {
                            BottomArrow(status: context.state.status, type: type)
                        })
                        .frame(maxWidth: .infinity)
                    
                }
            }
            // White Bar Connect Three White Point
            .overlay(alignment: .bottom, content: {
                // Image Size = 45 + Trailing Padding = 10
                // 55 / 2 = 27.5
                Rectangle()
                    .fill(.white.opacity(0.6))
                    .frame(height: 2)
                    .offset(y: 12)
                    .padding(.horizontal, 27.5)
            })
//            .padding(.leading, 15)
                                    .padding(.trailing, -20)
//            .frame(maxHeight: .infinity)
            .offset(y: -5)
        }
    }
    
    // MARK: Splitting Code
    @ViewBuilder
    func BottomArrow(status: Status, type: Status) -> some View {
        Image(systemName: "arrowtriangle.down.fill")
            .font(.system(size: 15))
            .scaleEffect(x: 1.3)
            .offset(y: 6)
            .opacity(status == type ? 1 : 0)
            .foregroundColor(.white)
            .overlay(alignment: .bottom) {
                Circle()
                    .fill(.white)
                    .frame(width: 5, height: 5)
                    .offset(y: 13)
                
            }
    }
    
    func message(status: Status) -> String {
        switch status {
        case .received:
            return OrderStatusThings.orderReceived.activityString
        case .progress:
            return OrderStatusThings.inProgress.activityString
        case .ready:
            return OrderStatusThings.orderReady.activityString
        }
    }
    
    func subMessage(status: Status) -> String {
        switch status {
        case .received:
            return OrderStatusThings.orderReceived.detailedDescrbing
        case .progress:
            return OrderStatusThings.inProgress.detailedDescrbing
        case .ready:
            return OrderStatusThings.orderReady.detailedDescrbing
        }
    }
}

enum AssetsThings: String {
    case green = "Green"
    case iconLogo = "Starbucks_Corporation_Logo_2011"
    case burger = "Burger"
    case shake = "Shake"
}
