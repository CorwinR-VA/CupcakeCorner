//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Corwin Rainier on 7/1/22.
//

import Introspect
import SwiftUI

struct ContentView: View {
    @Environment (\.colorScheme) var colorScheme
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cupcake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cupcakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
