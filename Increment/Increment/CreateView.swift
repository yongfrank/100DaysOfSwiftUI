//
//  CreateView.swift
//  Increment
//
//  Created by Frank Chu on 6/28/22.
//

import SwiftUI

struct CreateView: View {
    @StateObject var vm = ChallengePageViewModel()
//    @State private var isActive = false

    var dropList: some View {
        ForEach(vm.four.indices, id: \.self) { index in
            DropdownView(smallSection: $vm.four[index])
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                dropList
                Spacer()
//                NavigationLink(isActive: $isActive ) {
//                    RemindView()
//                } label: {
                Button {
                    vm.send(action: .createChallenge)
                } label: {
                    Text("Create")
                        .font(.system(size: 24, weight: .medium))
                }
//                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Create")
            .padding(.bottom, 15)
            .confirmationDialog("Selected",
                                isPresented: Binding<Bool>(
                                    get: { vm.hasSelectedDropdown },
                                    set: { _ in }
                                ))
            {
                ForEach(vm.displayedOptions.indices, id: \.self) { index in
                    Button(vm.displayedOptions[index].formatted) {
                        vm.send(action: .selectOption(index: index))
                    }
                }
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
