//
//  ContentView.swift
//  HotProspects
//
//  Created by Justin Wells on 11/28/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Text("Tab 1")
            Text("Tab 2")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
