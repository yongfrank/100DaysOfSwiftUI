//
//  Home.swift
//  FoodDeliveryApp
//
//  Created by Frank Chu on 9/12/22.
//  https://www.youtube.com/watch?v=_JTTzXmx0r0
//  SwiftUI Minimal App Animations - Food App UI - Xcode 14 - SwiftUI Tutorials


import SwiftUI

struct Home: View {
    
    // MARK: Carousel Properties
    @State private var currentIndex: Int = 0
    @State private var currentTab: Tab = tabs[1]
    @Namespace var animation
    
    
    // MARK: Detail View Properties
    @State var selectedMilkShake: MilkShake?
    @State var showDetail: Bool = false
    
    var body: some View {
        VStack {
            HeaderView()
            Group {
                Text(attributedTitle)
                Text(attributedSubTitle)
            }
            .font(.largeTitle.bold())
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(showDetail ? 0 : 1)
            
            GeometryReader { proxy in
                let size = proxy.size
                CarouselView(size: size)
            }
            .zIndex(-1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(content: {
            if let selectedMilkShake, showDetail {
                DetailView(animation: animation, milkShake: selectedMilkShake, show: $showDetail)
            }
        })
        .background {
            Color("LightGreen")
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func CarouselView(size: CGSize) -> some View {
        
        VStack {
            CustomCarousel(index: $currentIndex, items: milkShakes, spacing: 0, cardPadding: size.width / 3, id: \.id) { item, cardSize in
                // MARK: YOUR CUSTOM CELL VIEW
                VStack(spacing: 10) {
                    
                    ZStack {
                        if showDetail && selectedMilkShake?.id == item.id {
                            Image(item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .rotationEffect(.init(degrees: -2))
                                .opacity(0)
                        } else {
                            Image(item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .rotationEffect(.init(degrees: -2))
                                .matchedGeometryEffect(id: item.id, in: animation)
                        }
                    }
                    .background {
                        RoundedRectangle(cornerRadius: size.height / 10, style: .continuous)
                            .fill(Color("LightGreen-1"))
                            .padding(.top, 40)
                            .padding(.horizontal, -40)
                            .offset(y: -10)
                    }
                    //                    .frame(width: cardSize.width, height: cardSize.height)
                    //                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    Text(item.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                    
                    Text(item.price)
                        .font(.callout)
                        .fontWeight(.black)
                        .foregroundColor(Color("LightGreen"))
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                        selectedMilkShake = item
                        showDetail = true
                    }
                }
            }
            .frame(height: size.height * 0.7)
            Indicators()
                .padding(.bottom, 8)
        }
        .frame(width: size.width, height: size.height, alignment: .bottom)
        //        .padding(.horizontal)
        .padding(.bottom, 8)
        .opacity(showDetail ? 0 : 1)
        .background {
            CustomArcShape()
                .fill(.white)
                .scaleEffect(showDetail ? 1.8 : 1, anchor: .bottomLeading)
                .overlay(alignment: .topLeading, content: {
                    TabMenu()
                        .opacity(showDetail ? 0 : 1)
                })
                .padding(.top, 40)
                .ignoresSafeArea()
        }
    }
    
    // MARK: Custom Tab Menu's
    @ViewBuilder
    func TabMenu() -> some View {
        HStack(spacing: 30) {
            ForEach(tabs) { tab in
                Image(tab.tabImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 50)
                    .padding(10)
                    .background {
                        Circle()
                            .fill(Color("LightGreen-1"))
                    }
                    .background(content: {
                        Circle()
                            .fill(.white)
                            .padding(-2)
                    })
                    .shadow(color: .black.opacity(0.07), radius: 5, x: 5, y: 5)
                // MARK: I Already Pre-Defined the Offsets to make the look like Circular
                    .offset(tab.tabOffset)
                    .scaleEffect(currentTab.id == tab.id ? 1.15 : 0.94, anchor: .bottom)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            currentTab = tab
                        }
                    }
            }
        }
        .padding(.leading, 15)
    }
    
    // MARK: Indicators
    @ViewBuilder
    func Indicators() -> some View {
        HStack(spacing: 2) {
            ForEach(milkShakes.indices, id: \.self) { index in
                Circle()
                    .fill(Color("LightGreen"))
                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10: 6)
                    .padding(4)
                    .background {
                        if currentIndex == index {
                            Circle()
                                .stroke(Color("LightGreen"), lineWidth: 1)
                                .matchedGeometryEffect(id: "INDICATOR", in: animation)
                        }
                    }
            }
        }
        .animation(.easeOut, value: currentIndex)
    }
    
    func HeaderView() -> some View {
        HStack {
            Button {
                
            } label: {
                HStack(spacing: 10) {
                    Image("Pic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    
                    Text("iJustine")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                }
                .padding(.leading, 8)
                .padding(.trailing, 12)
                .padding(.vertical, 6)
                .background {
                    Capsule()
                        .fill(Color("LightGreen-1"))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(showDetail ? 0 : 1)
            
            
            // MARK: Going to show the same Button from Home View
            Button {
                
            } label: {
                Image(systemName: "cart")
                    .font(.title2)
                    .foregroundColor(.black)
                    .overlay(alignment: .topTrailing) {
                        Circle()
                            .fill(.red)
                            .frame(width: 10, height: 10)
                            .offset(x: 2, y: -5)
                    }
            }
        }
        .padding(15)
    }
    
    var attributedTitle: AttributedString {
        var attString = AttributedString(stringLiteral: "Good Food,")
        if let range = attString.range(of: "Food,") {
            attString[range].foregroundColor = .white
        }
        return attString
    }
    
    var attributedSubTitle: AttributedString {
        var attString = AttributedString(stringLiteral: "Good Mood.")
        if let range = attString.range(of: "Good") {
            attString[range].foregroundColor = .white
        }
        return attString
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
//        Home()
        Home(selectedMilkShake: milkShakes.first, showDetail: true)
    }
}

struct DetailView: View {
    
    enum OrderType: String, CaseIterable {
        case active = "Active Order"
        case past = "Past Order"
        
        var localizedName: LocalizedStringKey {
            LocalizedStringKey(rawValue)
        }
    }
    
    var animation: Namespace.ID
    var milkShake: MilkShake
    @Binding var show: Bool
    
    // MARK: View Properties
    @State var orderType: OrderType = .active
    @State var showContent: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.easeOut(duration: 0.35)) {
                        showContent = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeOut(duration: 0.35)) {
                            show = false
                        }
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(15)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .overlay {
                Text("Details")
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            .padding(.top, 7)
            .opacity(showContent ? 1 : 0)
            
            HStack {
                ForEach(OrderType.allCases, id: \.self) { order in
                    Text(order.localizedName)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(orderType == order ? .black : .gray)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(content: {
                            if orderType == order {
                                Capsule()
                                    .fill(Color("LightGreen-1"))
                                    .matchedGeometryEffect(id: "ORDERTAB", in: animation)
                            }
                        })
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                orderType = order
                            }
                        }
                }
            }
            .padding(.leading, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            .opacity(showContent ? 1 : 0)
            
            Image(milkShake.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(.init(degrees: -2))
                .matchedGeometryEffect(id: milkShake.id, in: animation)
            
            GeometryReader { proxy in
                let size = proxy.size
                
                MilkShakeDetails()
                    .offset(y: showContent ? 0 : size.height + 50)
            }
            .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .transition(.asymmetric(insertion: .identity, removal: .offset(y: 0.5)))
        .onAppear {
            withAnimation(.easeInOut.delay(0.1)) {
                showContent = true
            }
        }
    }
    
    func MilkShakeDetails() -> some View {
        VStack {
            VStack(spacing: 12) {
                Text("#512D Code")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Text(milkShake.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text(milkShake.price)
                    .font(.callout)
                    .fontWeight(.black)
                    .foregroundColor(Color("LightGreen"))
                
                Text("20min delivery")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                HStack(spacing: 12) {
                    Text("Quantity: ")
                        .font(.callout.bold())
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "minus")
                            .font(.title3)
                    }
                    
                    Text("\(2)")
                        .font(.title3)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                    }
                }
                .foregroundColor(.gray)
                
                Button {
                    
                } label: {
                    Text("Add to cart")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                        .background {
                            Capsule()
                                .fill(Color("LightGreen"))
                        }
                }
                .padding(.top, 10)
            }
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 40, style: .continuous)
                    .fill(Color("LightGreen-1"))
            }
            .padding(.horizontal, 60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
