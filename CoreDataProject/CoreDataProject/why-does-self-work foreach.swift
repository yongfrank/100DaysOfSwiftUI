//
//  why-does-self-work foreach.swift
//  CoreDataProject
//
//  Created by Frank Chu on 4/7/22.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct why_does_self_work_foreach: View {
    var body: some View {
        Form {
            
            Section {
                List {
                    ForEach([2, 4, 6, 8, 10], id: \.self) {
                        Text("\($0) is even")
                    }
                }
            }
            
            let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
            
            List(students, id: \.self) { student in
                Text(student.name)
            }
        }
    }
}

struct why_does_self_work_foreach_Previews: PreviewProvider {
    static var previews: some View {
        why_does_self_work_foreach()
    }
}
