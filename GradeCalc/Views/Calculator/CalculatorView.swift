//
//  ContentView.swift
//  SwiftUI-Calculator
//
//  Created by Priscilla Ip on 2020-07-15.
//  Copyright © 2020 Priscilla Ip. All rights reserved.
//

import SwiftUI

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

enum CalculatorButton: String {
    case zero, one, two, three, four, five, six, seven, eight, nine, decimal
    case equals, add, subtract, multiply, divide
    case ac, plusMinus, percent
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .plusMinus: return "±"
        case .percent: return "%"
        case .decimal: return "."
        case .equals: return "="
        default:
            return "AC"
        }
    }
    
    
    
    var backgroundColor: LinearGradient {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return gradientDarkBlue()
        case .plusMinus, .percent, .decimal:
            return gradientPurple()
        case .ac, .equals:
            return gradient()
        //case .decimal:
           // return gradientPurple()
        default:
            return gradientBlue()
        }
    }//DarkBlueBackground
    //LinearGradient
    
    
    var size: CGFloat {
        switch self {
        case .ac, .plusMinus, .percent:
            return 28.0
        default:
            return 32.0
        }
    }
}

//MARK: - Global Application State

class GlobalEnvironment: ObservableObject {
    
    @Published var display = "0"
    
    //MARK: - Variables and Properties
    
    private var isFinishedTypingNumber: Bool = true
    private var lastInput: CalculatorButton?
    
    private var displayValue: Double {
        get {
            guard let number = Double(self.display) else { fatalError("Cannot convert display label text to a Double") }
            return number
        }
        set {
            self.display = newValue.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", newValue) : String(newValue)
        }
    }

    private var calculator = CalculatorLogic()
    
    //MARK: - Internal Methods
    
    private func isLastInputOperator() -> Bool {
        guard let lastInput = lastInput else { return false }
            return lastInput == .divide || lastInput == .multiply || lastInput == .add || lastInput == .subtract
    }
    
    func receiveInput(calculatorButton: CalculatorButton) {

        switch calculatorButton {
        case .ac, .plusMinus, .percent, .divide, .multiply, .subtract, .add, .equals:
            
            // check for two consecutive operators
            if isLastInputOperator() { break }
            
            isFinishedTypingNumber = true
            
            calculator.setNumber(displayValue)

            if let result = calculator.calculate(symbol: calculatorButton) {
                displayValue = result
            }
            
        default:
            
            if isFinishedTypingNumber {
                
                // do not duplicate zeros
                if displayValue == 0 && calculatorButton == .zero { return }
                
                if calculatorButton == .decimal {
                    self.display = "0" + calculatorButton.title
                } else { self.display = calculatorButton.title }
                
                isFinishedTypingNumber = false
                
            } else {
                
                if calculatorButton == .decimal {
                    
                    // check if number is whole number
                    if self.display.contains(".") { return }

                    // check if number already has a decimal
                    let isInt = floor(displayValue) == displayValue
                    if !isInt { return }
                }
                self.display = self.display + calculatorButton.title
            }
        }
        lastInput = calculatorButton
    }
}

//MARK: - ContentView

struct CalculatorView: View {
    
    @EnvironmentObject var env: GlobalEnvironment

    let spacing: CGFloat = 16
    
    var buttonWidth = (UIScreen.main.bounds.width - 5 * 16) / 4
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equals]
    ]

    var body: some View {
        
        ZStack (alignment: .bottom) {
            Color("lightGrey").edgesIgnoringSafeArea(.all)
            
            VStack (spacing: self.spacing) {
                
                HStack {
                    Spacer()
                    Text(env.display).foregroundColor(Color("DarkBlueBackground"))
                        .font(.system(size: 100))
                        .fontWeight(.light)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }.padding(.trailing).padding(.trailing, buttonWidth / 2 / 4)
                
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: self.spacing) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
}

//MARK: - SubViews

struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    let spacing: CGFloat = 16
    
    let screenWidth = UIScreen.main.bounds.width
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Button(action: {
            self.env.receiveInput(calculatorButton: self.button)
        }) {
            Text(button.title)
                .font(.system(size: button.size))
                .fontWeight(.regular)
                .frame(width: self.buttonWidth(button: button), height: (screenWidth - 5 * self.spacing)  / 4)
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(self.buttonWidth(button: button))
           
        }//button.backgroundColor
    }

    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (screenWidth - 4 * self.spacing)  / 4 * 2
        }
        return (screenWidth - 5 * self.spacing)  / 4
    }
}

//MARK: - Previews

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView().environmentObject(GlobalEnvironment())
    }
}
