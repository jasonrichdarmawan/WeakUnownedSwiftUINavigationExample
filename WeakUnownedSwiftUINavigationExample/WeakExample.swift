//
//  ContentView.swift
//  SwiftUICoordinatorExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 01/08/23.
//

import SwiftUI

class Subscriber {
    let id: UUID
    
    init(id: UUID = UUID()) {
        self.id = id
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
}

class Publisher {
    let id: UUID
    
    // try to remove weak
    weak var subscriber: Subscriber?
    
    init(id: UUID = UUID()) {
        self.id = id
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
}

struct FeatureBView: View {
    let subscriber: Subscriber
    
    init(
        subscriber: Subscriber = Subscriber()
    ) {
        self.subscriber = subscriber
    }
    
    var body: some View {
        Text("Feature B")
    }
}

struct FeatureAView: View {
    @State private var isFeatureCPresented = false
    
    let publisher: Publisher
    
    init(publisher: Publisher = Publisher()) {
        self.publisher = publisher
    }
    
    var body: some View {
        VStack {
            Text("Feature A")
            
            Button {
                isFeatureCPresented = true
            } label: {
                Text("Feature B")
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationDestination(isPresented: $isFeatureCPresented) {
            NavigationLazyView {
                featureBView
            }
        }
    }
    
    private var featureBView: some View {
        let subscriber = Subscriber()
        publisher.subscriber = subscriber
        return FeatureBView(subscriber: subscriber)
    }
}
