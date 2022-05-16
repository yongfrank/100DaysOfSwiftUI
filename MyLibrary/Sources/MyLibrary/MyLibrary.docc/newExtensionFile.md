# ``MyLibrary/ContentView``

Extension file is the file which won't make your source code file messy

## Overview

This is the headline part. Representation of User Interface
 
This is the overview part. This will create the app interface, ``dollarFormat`` and ``tipPercentages``
 
 Example of something like ``dollarFormat``
 ```swift
 public var dollarFormat: FloatingPointFormatStyle<Double>.Currency {
     let currencyCode = Locale.current.currencyCode ?? "USD"
     return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
 }
 ```
 
 ```swift
 Picker("Tip percentage", selection: $tipPercentage) {
     ForEach(0 ..< 101) {
         Text($0, format: .percent)
     }
 }
 ```

## Topics

### There're also some groups

- ``tipPercentages``
