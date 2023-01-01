//
//  ActionViewController.swift
//  Extension
//
//  Created by Frank Chu on 12/19/22.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

/**
 Action for controller
 
 1. This is Note.
 2. apple
 
 ```
 func(add)
 ```
 
 123
 */
class ActionViewController: UIViewController {
    @IBOutlet var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
        
        /// 当我们的扩展被创建时，它extensionContext让我们控制它如何与父应用程序交互。
        /// 在这种情况下，`inputItems` 父应用程序将发送到我们的扩展程序以供使用的数据数组。
        /// 我们只关心这个项目中的第一个项目，即使这样它也可能不存在，所以我们有条件地使用`if let`and `as?`进行类型转换。
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            
            /// `let itemProvider: NSItemProvider`
            ///
            /// 我们的输入项包含一组附件，这些附件以`NSItemProvider`.
            /// 我们的代码从第一个输入项中提取第一个附件。
            if let itemProvider = inputItem.attachments?.first {
                
                /// item provider
                ///
                /// `itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String)` is a method of the UIActivityItemProvider class in the iOS SDK.
                /// It allows you to load an item from the activity item provider, specified by a type identifier.
                /// In this case, the type identifier is `kUTTypePropertyList`, which is a constant representing the type identifier for a property list file.
                /// 
                /// `kUTTypePropertyList` was deprecated in iOS 15.0: Use UTTypePropertyList instead.
                ///
                /// ```
                /// typealias CompletionHandler = @Sendable (NSSecureCoding?, Error?) -> Void
                ///
                /// open class NSItemProvider : NSObject, NSCopying {
                ///     func loadItem(
                ///         forTypeIdentifier typeIdentifier: String,
                ///         options: [AnyHashable : Any]? = nil,
                ///         completionHandler: NSItemProvider.CompletionHandler? = nil
                ///     )
                /// }
                ///```
                ///
                /// https://www.hackingwithswift.com/read/19/3/adding-an-extension-nsextensionitem
                /// 下一行用于`loadItem(forTypeIdentifier: )`要求项目提供者实际向我们提供它的项目，
                /// 但您会注意到它使用了一个闭包，因此这段代码是异步执行的。也就是说，该方法将在项目提供者忙于加载并向我们发送其数据时继续执行。
                /// 在我们的闭包中，我们首先需要通常`[weak self]`的方法来避免强引用循环，但我们还需要接受两个参数：项目提供者给我们的字典，以及发生的任何错误。
                ///
                /// The `[weak self]` in the completion block is used to prevent a strong reference cycle.
                /// It means that the self reference inside the block will be a weak reference, which means that it will not prevent the object from being deallocated.
                /// This is important to prevent a **retain cycle**, which can cause a memory leak.
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    // do stuff
                    guard let itemDictionary: NSDictionary = dict as? NSDictionary else { return }
                    guard let javaSceriptValues: NSDictionary = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    self?.pageTitle = javaSceriptValues["title"] as? String ?? ""
                    self?.pageURL = javaSceriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
//        var imageFound = false
//        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
//            for provider in item.attachments! {
//                if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
//                    // This is an image. We'll load it, then place it in our image view.
//                    weak var weakImageView = self.imageView
//                    provider.loadItem(forTypeIdentifier: UTType.image.identifier, options: nil, completionHandler: { (imageURL, error) in
//                        OperationQueue.main.addOperation {
//                            if let strongImageView = weakImageView {
//                                if let imageURL = imageURL as? URL {
//                                    strongImageView.image = UIImage(data: try! Data(contentsOf: imageURL))
//                                }
//                            }
//                        }
//                    })
//                    
//                    imageFound = true
//                    break
//                }
//            }
//            
//            if (imageFound) {
//                // We only handle one image, so stop looking for more.
//                break
//            }
//        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
//        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": self.script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        
        extensionContext?.completeRequest(returningItems: [item])
    }

}

/**
 This method sum two double numbers and returns.

 Here is the discussion. This methods adds two double and return the optional Double.


 - parameter number1: First Double Number.
 - parameter number2: Second Double Number.
 - returns: The sum of two double numbers.

 # Notes: #
 1. Parameters must be **double** type
 2. Handle return type because it is optional.

 # Example #
```
 if let sum = self.add(number1: 23, number2: 34) {
  print(sum)
 }
 ```
*/


func add(number1: Double, number2: Double) -> Double? {
    return number1 + number2
}
