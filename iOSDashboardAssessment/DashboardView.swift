//
//  DashboardView.swift
//  iOSDashboardAssessment
//
//  Created by Amilzith on 20/06/24.
//

import SwiftUI
import SampleData

struct DashboardView: View {
    var geometry: GeometryProxy?
    @ObservedObject var viewModel = DashboardViewModel()
    @State private var makeActive = false
    
    var body: some View {
        VStack() {
            ScrollView() {
                profileCard
                    .padding([.top, .bottom], 10)
                NavigationLink(destination: JobScreenView(viewModel: viewModel, makeActive: $makeActive, geometry: geometry, selectedCategory: .yetToStart), isActive: $makeActive) {
                    jobStatusCard
                        .padding(.bottom, 20)
                }
                invoiceStatusCard
                    .padding(.bottom, 20)
            }
            Spacer()
        }
        .padding(.top, 5)
        .background(Color(DashboardAssessmentColor.tertiarySystemBackground.rawValue))
    }
    var profileCard: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 10) {
                Text("Hello Abdul Kalam! 👋")
                    .font(.system(size: (geometry?.size.width ?? 0.0) * 0.040))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text(Date().formattedString())
                    .font(.system(size: (geometry?.size.width ?? 0.00) * 0.040))
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
            }
            .padding(.leading, (geometry?.size.width ?? 0.0) * 0.030)
            Spacer()
            Image("Profile")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(5)
                .frame(width: (geometry?.size.width ?? 0) * 0.1, height: (geometry?.size.width ?? 0) * 0.1)
                .background(Color.red)
                .padding(.trailing, (geometry?.size.width ?? 0) * 0.06)
        }
        .padding([.top, .bottom], (geometry?.size.width ?? 0) * 0.04)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5).foregroundColor(Color.gray))
        .background(Color.white)
        .cornerRadius(10)
        .padding([.leading, .trailing], (geometry?.size.width ?? 0) * 0.05)
    }
    
    var jobStatusCard: some View {
        VStack(alignment: .leading) {
            HStack() {
                Text("Job stats")
                    .font(.system(size: (geometry?.size.width ?? 0.0) * 0.040))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.top, (geometry?.size.width ?? 0) * 0.02)
                Spacer()
            }
            .padding(.leading, (geometry?.size.width ?? 0.0) * 0.025)
            VStack{
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 0.5)
            .background(Color.gray)
            
            .padding([.top, .bottom], (geometry?.size.width ?? 0.0) * 0.010)
            .padding([.leading, .trailing], (geometry?.size.width ?? 0.0) * 0.025)
            ChartView(viewModel: viewModel, geometry: geometry, isJobStatus: true)
                .padding([.leading, .trailing, .bottom], (geometry?.size.width ?? 0.0) * 0.025)
            CharHighlightView(viewModel: viewModel, geometry: geometry, isJobStatus: true)
                .padding([.leading, .trailing, .bottom], (geometry?.size.width ?? 0.0) * 0.025)
        }
        
        .background(Color.white)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5).foregroundColor(Color.gray))
        .cornerRadius(10)
        .padding([.leading, .trailing], (geometry?.size.width ?? 0) * 0.05)
    }
    
    var invoiceStatusCard: some View {
        VStack(alignment: .leading) {
            HStack() {
                Text("Invoice stats")
                    .font(.system(size: (geometry?.size.width ?? 0.0) * 0.040))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.top, (geometry?.size.width ?? 0) * 0.02)
                Spacer()
            }
            .padding(.leading, (geometry?.size.width ?? 0.0) * 0.025)
            VStack{}
                .frame(maxWidth: .infinity)
                .frame(height: 0.5)
                .background(Color.gray)
            
                .padding([.top, .bottom], (geometry?.size.width ?? 0.0) * 0.010)
                .padding([.leading, .trailing], (geometry?.size.width ?? 0.0) * 0.025)
            ChartView(viewModel: viewModel, geometry: geometry, isJobStatus: false)
                .padding([.leading, .trailing, .bottom], (geometry?.size.width ?? 0.0) * 0.025)
            CharHighlightView(viewModel: viewModel, geometry: geometry, isJobStatus: false)
                .padding([.bottom], (geometry?.size.width ?? 0.0) * 0.025)
                .padding([.leading, .trailing], (geometry?.size.width ?? 0.0) * 0.00)
        }
        .background(Color.white)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5).foregroundColor(Color.gray))
        .cornerRadius(10)
        .padding([.leading, .trailing], (geometry?.size.width ?? 0) * 0.05)
    }
}

#Preview {
    ContentView()
}

