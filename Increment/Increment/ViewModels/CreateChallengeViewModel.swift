//
//  CreateChallengeViewModel.swift
//  Increment
//
//  Created by Frank Chu on 6/28/22.
//

import Foundation
import Combine

typealias UserId = String

final class ChallengePageViewModel: ObservableObject {
    @Published var four: [TypeOfFour] = [
        .init(typeOfFour: .exercise),
        .init(typeOfFour: .startAmount),
        .init(typeOfFour: .increase),
        .init(typeOfFour: .days)
    ]
    
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum SendAction {
        case selectOption(index: Int)
        case createChallenge
    }
    
    var hasSelectedDropdown: Bool {
        four.first(where: { $0.isSelected }) != nil
//        selectedDropdownIndex != nil
    }
    
    var selectedDropdownIndex: Int? {
        four.enumerated().first(where: { $0.element.isSelected })?.offset
    }
    
    var displayedOptions: [DropdownOption] {
        guard let selectedDropdownIndex = selectedDropdownIndex else {
            return []
        }
        return four[selectedDropdownIndex].options
    }
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func send(action: SendAction) {
        switch action {
        case .selectOption(let index):
            guard let selectedDropdownIndex = selectedDropdownIndex else { return }
            clearSelectedOption()
            four[selectedDropdownIndex].options[index].isSelected = true
            clearSelectedDropdown()
        case .createChallenge:
            print("create challenge")
            currentUserId().sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    print("completed")
                }
            } receiveValue: { userId in
                print("Retrived userid = \(userId)")
            }.store(in: &cancellables )

        }
    }
    
    private func clearSelectedOption() {
        guard let selectedDropdownIndex = selectedDropdownIndex else {
            return
        }
        four[selectedDropdownIndex].options.indices.forEach { index in
            four[selectedDropdownIndex].options[index].isSelected = false
        }

    }
    
    private func clearSelectedDropdown() {
        guard let selectedDropdownIndex = selectedDropdownIndex else {
            return
        }
        four[selectedDropdownIndex].isSelected = false
    }
    
    private func currentUserId() -> AnyPublisher<UserId, Error> {
        print("getting user id")
        return userService.currentUser().flatMap { user -> AnyPublisher<UserId, Error> in
            if let userid = user?.uid {
                print("user is logged in...")
                return Just(userid)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                print("user is being logged in anonymously")
                return self.userService
                    .signInAnonymously()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
}

struct DropdownOption {
    enum DropdownOptionType {
        case text(String), num(Int)
    }

    let type: DropdownOptionType
    let formatted: String
    var isSelected: Bool
}

protocol TypeOfFourProtocol {
    var options: [DropdownOption] { get set }
    var headerTitle: String { get }
    var title: String { get }
    var isSelected: Bool { get set }
}

extension ChallengePageViewModel {
    struct TypeOfFour: TypeOfFourProtocol {
        var options: [DropdownOption]
        var headerTitle: String {
            typeOfFour.rawValue
        }

        var title: String {
            options.first(where: { $0.isSelected == true })?.formatted ?? "Wrong"
        }

        var isSelected: Bool = false
        
        let typeOfFour: FourTypeName
        
        init(typeOfFour: FourTypeName) {
            switch typeOfFour {
            case .exercise:
                self.options = ExerciseOption.allCases.map { $0.nameOfExercise }
            case .startAmount:
                self.options = StartAmountOption.allCases.map { $0.nameOfStartAmout }
            case .increase:
                self.options = IncreaseOption.allCases.map { $0.nameOfStartAmout }
            case .days:
                self.options = LengthOption.allCases.map { $0.nameOfStartAmout }
            }
            self.typeOfFour = typeOfFour
        }
        
        enum FourTypeName: String {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case days = "Challenge Length"
        }
        
        enum ExerciseOption: String, CaseIterable {
            case pullups
            case situps
            case pushups
            
            var nameOfExercise: DropdownOption {
                .init(
                    type: .text(rawValue),
                    formatted: rawValue.capitalized,
                    isSelected: self == .pullups
                )
            }
        }

        enum StartAmountOption: Int, CaseIterable {
            case one = 1, two, three, four, five
            
            var nameOfStartAmout: DropdownOption {
                .init(
                    type: .num(rawValue),
                    formatted: "\(rawValue)",
                    isSelected: self == .one
                )
            }
        }

        enum IncreaseOption: Int, CaseIterable {
            case one = 1, two, three, four, five
            
            var nameOfStartAmout: DropdownOption {
                .init(
                    type: .num(rawValue),
                    formatted: "+\(rawValue)",
                    isSelected: self == .one
                )
            }
        }

        enum LengthOption: Int, CaseIterable {
            case seven = 7, fourteen = 14, twenty = 21, ewentyEight = 28
            
            var nameOfStartAmout: DropdownOption {
                .init(
                    type: .num(rawValue),
                    formatted: "\(rawValue) days",
                    isSelected: self == .fourteen
                )
            }
        }
    }
}

