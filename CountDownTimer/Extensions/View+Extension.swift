//
//  View+Extension.swift
//  CountDownTimer
//
//  Created by MacBook on 24/12/2023.
//

import Foundation
import SwiftUI

extension View {
  func customButtonDesign() -> some View {
    ModifiedContent(
      content: self,
      modifier: CustomButtonModifier()
    )
  }
}
