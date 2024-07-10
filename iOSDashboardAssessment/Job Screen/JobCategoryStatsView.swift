//
//  JobCategoryStatsView.swift
//  iOSDashboardAssessment
//
//  Created by Amilzith on 21/06/24.
//

import SwiftUI
import SampleData

struct JobCategoryStatsView: View {
    var jobs: [JobApiModel]?
    var geometry: GeometryProxy?
    @Binding var selectedTab: Int
    @Binding var selectedCategory: JobStatus
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 0) {
                    ForEach(Array((JobStatus.allCases).enumerated()), id: \.element) { row, value in
                        Button(action: {
                            withAnimation {
                                selectedTab = Int(row)
                                selectedCategory = value
                            }
                        }, label: {
                            VStack(spacing: 0) {
                                HStack {
                                    Text("\(String(describing: value)) (\(getJobCount(status: value)))")
                                        .font(.system(size: (geometry?.size.width ?? 0.0) * 0.040))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .padding([.leading, .trailing], 20)
                                }
                                .frame(height: 30)
                                Rectangle().fill(selectedTab == row ? Color.blue : Color.gray)
                                    .frame(height: selectedTab == row ?  3 : 1)
                            }
                            .fixedSize()
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .padding(.bottom, 10)
    }
    
    func getJobCount(status: JobStatus) -> Int {
        return jobs?.filter({$0.status == status}).count ?? 0
    }
}

#Preview {
    JobCategoryStatsView(selectedTab: .constant(0), selectedCategory: .constant(.completed))
}

