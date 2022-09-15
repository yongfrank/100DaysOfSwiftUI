//
//  CustomCarousel.swift
//  FoodDeliveryApp
//
//  Created by Frank Chu on 9/12/22.
//  https://www.youtube.com/watch?v=6gAqdamj6tg
//  SwiftUI Animated Carousel - Xcode 14 - SwiftUI Tutorials | Animation Challenge

import SwiftUI

struct CustomCarousel<Content: View, Item, ID>: View where Item: RandomAccessCollection, ID: Hashable, Item.Element: Equatable {
        
    // MARK: View Properties
    @Binding var index: Int
    var items: Item
    var spacing: CGFloat
    var cardPadding: CGFloat
    
    var content: (Item.Element, CGSize) -> Content
    var id: KeyPath<Item.Element, ID>

    
    init(
        index: Binding<Int>,
        items: Item,
        spacing: CGFloat = 30,
        cardPadding: CGFloat = 80,
        
        id: KeyPath<Item.Element, ID>,
        @ViewBuilder content: @escaping (Item.Element, CGSize) -> Content
    ) {
        self.content = content
        self.id = id
        
        // MARK: View Properties
        self._index = index
        self.spacing = spacing
        self.cardPadding = cardPadding
        self.items = items
    }
    
    // MARK: Gesture Properties
    @GestureState var translation: CGFloat = 0
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    
    @State var currentIndex: Int = 0
    
    // MARK: Rotation
    @State var rotation: Double = 0
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            // MARK: Reduced After Applying Card Spacing & Padding
            let cardWidth = size.width - (cardPadding - spacing)
            
            
            LazyHStack(spacing: spacing) {
                ForEach(items, id: id) { item in
                    // Since We Already Applied Spacing
                    // And Again We're Adding it to Frame
                    // So Simply Removing the Spacing
                    
                    let index = indexOf(item: item)
                    content(item, CGSize(width: size.width - cardPadding, height: size.height))
                    // MARK: Rotating Each View 5 Deg Multipled With it's Index
                    // AND While Scrolling Setting it to 0, thus it will give some nice Circular Carousel Effect
                        .rotationEffect(.init(degrees: Double(index) * 5), anchor: .bottom)
                        .rotationEffect(.init(degrees: rotation), anchor: .bottom)
                    // MARK: Applying After Rotation, Thus You will Get Smooth Effect
                        .offset(y: offsetY(index: index, cardWidth: cardWidth))
                        .frame(width: size.width - cardPadding, height: size.height)
                        .contentShape(Rectangle())
                }
            }
            .padding(.horizontal, spacing)
            .contentShape(Rectangle())
            .offset(x: limitScroll())
            .gesture(
                DragGesture(minimumDistance: 5)
                    .updating($translation, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onChanged {
                        onChanged(value: $0, cardWidth: cardWidth)
                    }
                    .onEnded {
                        onEnd(value: $0, cardWidth: cardWidth)
                    }
            )
        }
        .padding(.top, 60)
        .onAppear {
            let extraSpace = (cardPadding / 2) - spacing
            offset = extraSpace
            lastStoredOffset = extraSpace
        }
        .animation(.easeOut, value: translation == 0)
    }
    
    // MARK: Moving Current Item Up
    func offsetY(index: Int, cardWidth: CGFloat) -> CGFloat {
        // MARK: We're Converting The Current Translation, Not While Offset
        // That's Why Created @GestureState to Hold the Current Translation Data
        
        // Converting Translation to -60...60
        let progress = ((translation < 0 ? translation : -translation) / cardWidth) * 60
        let yOffset = -progress < 60 ? progress : -(progress + 120)
        
        // MARK: Checking Previous, Next And In-Between Offsets
        let previous = (index - 1) == self.index ? (translation < 0 ? yOffset : -yOffset) : 0
        let next = (index + 1) == self.index ? (translation < 0 ? -yOffset : yOffset) : 0
        let in_Between = (index - 1) == self.index ? previous : next
        
        return index == self.index ? -60 - yOffset : in_Between
        
//        .updating($translation, body: { value, out, _ in
//            out = value.translation.width
//        })
    }
    
    // MARK: Item Index
    func indexOf(item: Item.Element) -> Int {
        let array = Array(items)
        if let index = array.firstIndex(of: item) {
            return index
        }
        
        return 0
    }
    
    // MARK: Limiting Scroll On First And Last Items
    func limitScroll() -> CGFloat {
        let extraSpace = (cardPadding / 2) - spacing
        
        if index == 0 && offset > extraSpace {
            return extraSpace + (offset / 4)
        } else if index == items.count - 1 && translation < 0 {
            return offset - (translation / 2)
        } else {
            return offset
        }
    }
    
    func onChanged(value: DragGesture.Value, cardWidth: CGFloat) {
        let translationX = value.translation.width
        self.offset = translationX + self.lastStoredOffset
        
        // MARK: Calculating Rotation
        let progress = offset / cardWidth
        self.rotation = progress / 5
    }
    
    func onEnd(value: DragGesture.Value, cardWidth: CGFloat) {
        var _index = (offset / cardWidth).rounded()
        _index = max(-CGFloat(items.count - 1), _index)
        _index = min(_index, 0)
        
        currentIndex = Int(_index)
        
        // MARK: Updating Index
        // Note Since We're Moving On Right Side
        // So All Data Will be Negative
        
        index = -currentIndex
        
        withAnimation(.easeOut(duration: 0.25)) {
            
            let extraSpace = (cardPadding / 2) - spacing
            offset = (cardWidth * _index) + extraSpace
            
            // MARK: Calculating Rotation
            let progress = offset / cardWidth
            // Since Index Starts With Zero
            self.rotation = (progress * 5).rounded() - 1
            
        }
        self.lastStoredOffset = offset
    }
}

struct CustomCarousel_Previews: PreviewProvider {
    static var previews: some View {
//        CustomCarousel()
//        CustomTab()
        Home()
    }
}
