//
//  K.swift
//  One Minute Timer
//
//  Created by Saqlain Bhatti on 23/12/2023.
//

import SwiftUI

///Will hold App Constants K is used to keep the code clean and easily readable
enum K{

    case progressBarWidth
    case progressViewSize
    
    var value: CGFloat{
        switch self {
        case .progressBarWidth:
            8
        case .progressViewSize:
            200
        }
    }
}
