////
////  Day68-2-writing-data-to-the-documents-directory.swift
////  BucketList
////
////  Created by Frank Chu on 6/8/22.
////
//
//import SwiftUI
//
//struct Day68_2_writing_data_to_the_documents_directory: View {
//    var body: some View {
//        
//        VStack {
//            Text("HI")
//                .onTapGesture {
//                    let a = FileManager.default.getDocumentsDirectoryFileManager()
//                    print(a)
//                    
//                    let str = "Frank is sooooo handsome!"
//                    let url = a.appending(path: "message.txt")
//                    
//                    
//                    
//                    print(url)
//                    do {
//                        try str.write(to: url, atomically: true, encoding: .utf8)
//                        let input = try String(contentsOf: url)
//                        print(input)
//                    } catch {
//                        print(error.localizedDescription)
//
//                    }
//                    
//            }
//            Text("I'm Frank")
//                .onTapGesture {
//                    FileManager.default.saveToFile(filePath: "hello.txt", fileContent: "Hi I'm Frank")
//                }
//        }
//    }
//   
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//}
//
//extension FileManager {
//    func getDocumentsDirectoryFileManager() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//    
//    func saveToFile(filePath: String, fileContent: String) {
//        let url = getDocumentsDirectoryFileManager().appending(path: filePath)
//        
//        do {
//            try fileContent.write(to: url, atomically: true, encoding: .utf8)
//            print(url)
//            print(try! String(contentsOf: url))
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}
//
//struct Day68_2_writing_data_to_the_documents_directory_Previews: PreviewProvider {
//    static var previews: some View {
//        Day68_2_writing_data_to_the_documents_directory()
//    }
//}
