//
//  HomeView.swift
//  GradeCalc
//
//  Created by Marwah Ameen on 09/07/1444 AH.
//

import SwiftUI


struct HomeView: View {
    var body: some View {
        
        NavigationView{
            VStack{
                if #available(iOS 15.0, *) {
                    Text("Student Tools")
                        .font(.system(size: 45))
                        .fontWeight(.heavy)
                        .foregroundStyle(
                            gradient())
                } else {
                    // Fallback on earlier versions
                    Text("Student Tools")
                        .font(.system(size: 45))
                        .fontWeight(.heavy)
                }
                    
                    
                Image("student")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 40)
                    .padding(.bottom, 40)
                
                NavigationLink(destination: CalculatorView().environmentObject(GlobalEnvironment())){
                    Text("Calculator")
                        .font(.title2)
                }
                .padding(15)
                .frame(width: 190,height: 50, alignment: .center)
                .foregroundColor(.white)
                .background(gradient())
                .cornerRadius(30)
                
                .shadow(radius: 3, x: 3, y:  3)
                
                NavigationLink(destination: SubjectListView()){
                    Text("Calculate GPA")
                        .font(.title2)
                }
                .padding(15)
                .frame(width: 250,height: 50, alignment: .center)
                .foregroundColor(.white)
                .background(gradient())
                .cornerRadius(30)
                .shadow(radius: 3, x: 3, y:  3)
                
                NavigationLink(destination: SessionTimer()){
                    Text("Pomodoro Timer")
                        .font(.title2)
                }
                .padding(15)
                .frame(width: 250,height: 50, alignment: .center)
                .foregroundColor(.white)
                .background(gradient())
                .cornerRadius(30)
                .shadow(radius: 3, x: 3, y:  3)
                
                NavigationLink(destination: ToDo()){
                    Text("To Do List")
                        .font(.title2)
                }
                .padding(15)
                .frame(width: 190,height: 50, alignment: .center)
                .foregroundColor(.white)
                .background(gradient())
                .cornerRadius(30)
                .shadow(radius: 3, x: 3, y:  3)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
