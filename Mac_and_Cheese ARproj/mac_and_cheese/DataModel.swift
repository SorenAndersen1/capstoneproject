//
//  DataModel.swift
//  remote_identify
//
//  Created by user183837 on 1/28/21.
//

import SwiftUI

final class DataModel: ObservableObject{
    static var shared = DataModel()
   // @Published var arView: arView!
    @Published var step: Float = 0 {
        didSet {stepTransfer()}
    }
    func stepTransfer(){
        let step_hold = step + 1
        step = step_hold
    }
}

