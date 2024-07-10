//
//  ContentView.swift
//  iOSDashboardAssessment
//
//  Created by SabariZuper on 15/05/24.
//

import SwiftUI
import SampleData

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    DashboardView(geometry: geometry)
                }
                .background(Color(DashboardAssessmentColor.tertiarySystemBackground.rawValue))
                .navigationBarItems(
                    leading: Text("Dashboard")
                        .font(Font.system(size: geometry.size.width * 0.05))
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}


enum DashboardAssessmentColor: String {
    case tertiarySystemBackground = "TertiarySystemBackground"
    case completedStatus = "CompletedStatus"
    case cancelledStatus = "CancelledStatus"
    case incompleteStatus = "IncompleteStatus"
    case yettostartStatus = "YettostartStatus"
    case inprogressStatus = "InprogressStatus"
}
