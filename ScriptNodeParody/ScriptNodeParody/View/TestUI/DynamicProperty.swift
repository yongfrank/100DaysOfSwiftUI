//
//  DynamicProperty.swift
//  ScriptNodeParody
//
//  Created by Frank Chu on 3/26/23.
//

import SwiftUI

//@propertyWrapper
//struct MyDynamicProperty: DynamicProperty {
//    var wrappedValue: <#Value#>
//    @State var value: String
//
//    mutating func update() {
//        // Do something when the dynamic property changes
//    }
//}

struct DynamicProperty: View {
    
    @State var text = ""

    var body: some View {
        VStack {
            TextField("Enter text", text: $text)
//            MyDynamicProperty(value: text)
        }
    }

}

struct DynamicProperty_Previews: PreviewProvider {
    static var previews: some View {
        DynamicProperty()
    }
}
