import SwiftUI
import PlaygroundSupport
var dollarFormatter : FloatingPointFormatStyle<Double>.Currency {
    let currencyCode = Locale.current.currencyCode ?? "USD"
    return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
}

struct dollarView : View {
    var checkAmount = 7132.42  // note! using a Double. Will this work with an Integer?
    var body: some View {
        Section {
            // Which version is more declarative?
            Text(checkAmount, format: dollarFormatter)
            // verify against previous version...
            Text(checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
        }
    }
}

// Show SwiftUI views in Playground
PlaygroundPage.current.setLiveView( dollarView() )
