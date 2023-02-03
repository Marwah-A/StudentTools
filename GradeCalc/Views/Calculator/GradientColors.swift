//
//  GradientColors.swift
//  GradeCalc
//
//  Created by Marwah Ameen on 11/07/1444 AH.
//
//

import Foundation
import SwiftUI

func gradient() -> LinearGradient{
    return LinearGradient(gradient: Gradient(colors: [Color(UIColor(named: "GradientColor1") ?? .blue), Color(UIColor(named: "GradientColor2") ?? .purple)]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
func gradientBlue() -> LinearGradient{
    return LinearGradient(gradient: Gradient(colors: [Color(UIColor(named: "GradientColor1") ?? .blue), Color(UIColor(named: "GradientColor1") ?? .purple)]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
func gradientPurple() -> LinearGradient{
    return LinearGradient(gradient: Gradient(colors: [Color(UIColor(named: "GradientColor2") ?? .blue), Color(UIColor(named: "GradientColor2") ?? .purple)]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
func gradientDarkBlue() -> LinearGradient{
    return LinearGradient(gradient: Gradient(colors: [Color(UIColor(named: "DarkBlueBackground") ?? .blue), Color(UIColor(named: "DarkBlueBackground") ?? .purple)]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
