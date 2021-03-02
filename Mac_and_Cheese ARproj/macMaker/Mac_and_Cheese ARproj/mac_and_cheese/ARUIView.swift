//
//  ARUIView.swift
//  remote_identify
//
//  Created by user183837 on 1/28/21.
//

import SwiftUI

struct ARUIView: View {
    @EnvironmentObject var data: DataModel
    var body: some View {
        List{
            Stepper("Step: \(Int(data.step))", value: $data.step, in: 0...3)
        }
        .frame(width: CGFloat(50))
    }
}

struct ARUIView_Previews: PreviewProvider {
    static var previews: some View {
        ARUIView()
    }
}
