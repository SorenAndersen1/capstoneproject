//
//  ContentView.swift
//  remote_identify
//
//  Created by user183837 on 1/28/21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @EnvironmentObject var data: DataModel
    var body: some View {
        HStack {
            ARUIView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
