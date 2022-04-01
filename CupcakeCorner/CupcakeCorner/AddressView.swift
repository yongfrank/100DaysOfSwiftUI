//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Frank Chu on 4/1/22.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var orderPassIn: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderPassIn.name)
                TextField("Street Address", text: $orderPassIn.streetAddress)
                TextField("City", text: $orderPassIn.city)
                TextField("Zip", text: $orderPassIn.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: orderPassIn)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!orderPassIn.hasValidAddress)
            
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderPassIn: Order())
    }
}
