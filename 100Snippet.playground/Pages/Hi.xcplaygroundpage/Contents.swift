protocol MyProtocol {
    
}

struct MyStruct: MyProtocol {
    
}


//extension MyStruct {
//    func extensionMethod() { print("结构体") }
//}

extension MyProtocol {
    func extensionMethod() { print("协议") }
}

let myStruct = MyStruct()
myStruct.extensionMethod() // -> “结构体”

let proto: MyProtocol = myStruct
proto.extensionMethod() // -> “协议”
