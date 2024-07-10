//
//  ChartView.swift
//  iOSDashboardAssessment
//
//  Created by Amilzith on 21/06/24.
//

import SwiftUI
import SampleData

struct ChartView: View {
    @ObservedObject var viewModel = DashboardViewModel()
    var geometry: GeometryProxy?
    var isJobStatus = false
    
    var body: some View {
        VStack(spacing: 15) {
            HStack() {
                Text(firstLableValue)
                    .font(.system(size: (geometry?.size.width ?? 0.0) * 0.030))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                Spacer()
                Text(getTotalCount())
                    .font(.system(size: (geometry?.size.width ?? 0.0) * 0.030))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
            }
            ColorSetupCellView(allJobs: viewModel.allJobs, allInvoice: viewModel.allInvoiceList, isJobStatus: isJobStatus)
        }
    }
    
    var firstLableValue: String {
        return  isJobStatus ? "\(viewModel.allJobs?.count ?? 0) Jobs" : "Total values(\(dollerFormat(number: viewModel.totalInvoice ?? 0)))"
    }
    
    func getTotalCount() -> String {
        let count = isJobStatus ? viewModel.allJobs?.filter({$0.status == .completed}).count ?? 0 :  viewModel.allInvoiceList?.filter({$0.status == .paid}).count ?? 0
        return isJobStatus ? "\(count) of \(viewModel.allJobs?.count ?? 0) completed" : "\(dollerFormat(number: viewModel.getCollectedCount()) ) collected"
    }
    
    func dollerFormat(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        
        if let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString
        } else {
            return ""
        }
    }
}

#Preview {
    ChartView()
}
