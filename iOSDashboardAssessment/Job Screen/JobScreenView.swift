//
//  JobScreenView.swift
//  iOSDashboardAssessment
//
//  Created by Amilzith on 20/06/24.
//

import SwiftUI
import SampleData

struct JobScreenView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = DashboardViewModel()
    @Binding var makeActive: Bool
    var geometry: GeometryProxy?
    
    @State var selectedTab: Int = 0
    @State var selectedCategory: JobStatus
    
    var body: some View {
        VStack {
            ScrollView {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 0.2)
                    .background(Color.gray)
                HStack {
                    ChartView(viewModel: viewModel, geometry: geometry, isJobStatus: true)
                }
                .padding([.leading, .trailing], (geometry?.size.width ?? 0) * 0.05)
                .padding([.top, .bottom], 10)
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 0.5)
                    .background(Color.gray)
                JobCategoryStatsView(jobs: viewModel.allJobs, geometry: geometry, selectedTab: $selectedTab, selectedCategory: $selectedCategory)
                if let jobs = getFilterJob(status: selectedCategory) {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 15) {
                    ForEach(jobs, id: \.id) { job in
                        JobDetailView(job: job, geometry: geometry)
                    }
                }
                                                    }
            }
            .refreshable {
                viewModel.getJobList(status: selectedCategory)
            }
        }
        .padding(.top, 5)
        .background(Color(DashboardAssessmentColor.tertiarySystemBackground.rawValue))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                HStack {
            Button(action: {
                makeActive = false
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.backward")
                    .tint(Color.black)
            }
            Spacer()
            Text("Jobs(\(viewModel.allJobs?.count ?? 0))")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
        }
        )
    }
    
    func getFilterJob(status: JobStatus) -> [JobApiModel]? {
        return viewModel.allJobs?.filter({$0.status == status})
    }
}

#Preview {
    JobScreenView(makeActive: .constant(false), geometry: nil, selectedCategory: .completed)
}
