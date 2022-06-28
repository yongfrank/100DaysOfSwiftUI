//
//  DropdownView.swift
//  Increment
//
//  Created by Frank Chu on 6/28/22.
//

import SwiftUI

struct DropdownView<T: TypeOfFourProtocol>: View {
    @Binding var smallSection: T
//    @State private var sheetIsVisible = false
    var body: some View {
        
        VStack {
            
            HStack {
                Text(smallSection.headerTitle)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }
            .padding(.vertical, 10)
            Button {
                smallSection.isSelected = true
//                sheetIsVisible.toggle()
            } label: {
                HStack {
                    Text(smallSection.title)
                        .font(.system(size: 28, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                }
            }
            .buttonStyle(PrimaryButtonStyle(fillColor: .primaryButton))
        }
//        .confirmationDialog("Select", isPresented: $sheetIsVisible) {
//            ForEach(smallSection.options.indices, id: \.self) { index in
//                Button(smallSection.options[index].formatted) {
//                    for i in 0..<smallSection.options.count {
//                        smallSection.options[i].isSelected = false
//                    }
//                    smallSection.options[index].isSelected = true
//                }
//            }
//        }
        .padding(15)
    }
}
//
//struct DropdownView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            DropdownView()
//        }
//        .preferredColorScheme(.dark)
//
//        NavigationView {
//            DropdownView()
//        }
//    }
//}
