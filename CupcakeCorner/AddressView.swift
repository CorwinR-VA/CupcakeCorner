//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Corwin Rainier on 7/1/22.
//

import SwiftUI

struct AddressView: View {
    @Environment (\.colorScheme) var colorScheme
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
                .disabled(order.hasValidAddress == false)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .background(
            ZStack {
                Color(UIColor.systemGroupedBackground)
                Image("cupcakeBackground")
                    .resizable(resizingMode: .tile)
                    .opacity(colorScheme == .dark ? 0.1 : 1.0)
            }
            .edgesIgnoringSafeArea(.all)
        )
        .introspectTableView { tableView in
            tableView.backgroundColor = .clear
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
