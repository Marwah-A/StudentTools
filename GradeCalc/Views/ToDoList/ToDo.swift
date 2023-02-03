//
//  ToDo.swift
//  GradeCalc
//
//  Created by Marwah Ameen on 10/07/1444 AH.
//
//

import SwiftUI

struct ToDo: View {
    var body: some View {
        VStack{
            if #available(iOS 15.0, *) {
                Text("This feature is under developing")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundStyle(gradient())
            } else {
                // Fallback on earlier versions
            }
                
            
            Image("under")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .padding(.top, 0)
            
            if #available(iOS 15.0, *) {
                Text("Please, wait for it!")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundStyle(gradient())
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct ToDo_Previews: PreviewProvider {
    static var previews: some View {
        ToDo()
    }
}
