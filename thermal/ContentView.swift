//
//  ContentView.swift
//  thermal
//
//  Created by timko on 18/08/2021.
//

import SwiftUI

struct ContentView: View {
    let data: String
    var body: some View {
        Text(String(data))
            .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(data: "")
    }
}
