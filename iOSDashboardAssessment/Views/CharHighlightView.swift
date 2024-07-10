//
//  CharHighlightView.swift
//  iOSDashboardAssessment
//
//  Created by Amilzith on 21/06/24.
//

import SwiftUI
import SampleData

struct CharHighlightView: View {
    @ObservedObject var viewModel = DashboardViewModel()
    var geometry: GeometryProxy?
    var isJobStatus = false
    
    var body: some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        VStack(alignment: .leading) {
            if isJobStatus {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 10)  {
                    ForEach(Array((JobStatus.allCases).enumerated()), id: \.element) { row, value in
                        HStack() {
                            Rectangle()
                                .fill(Color(jobColor(status: value)))
                                .frame(width: 10, height: 10)
                            Text(displayJobName(status: value))
                                .font(.system(size: (geometry?.size.width ?? 0.0) * 0.030))
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .frame(alignment: .leading)
                        .frame(width: 150)
                    }
                }
                .padding(.leading, 30)
            } else {
                LazyVGrid(columns: columns, alignment: .center, spacing: 10)  {
                    ForEach(Array((InvoiceStatus.allCases).enumerated()), id: \.element) { row, value in
                        HStack(spacing: 5) {
                            Rectangle()
                                .fill(Color(invoiceColor(status: value)))
                                .frame(width: 10, height: 10)
                            Text(displayInvoiceRole(status: value))
                                .font(.system(size: (geometry?.size.width ?? 0.0) * 0.030))
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                        }
                        .frame(alignment: .leading)
//                        .frame(width: 150)
                    }
                }
                .padding(.leading, 30)
            }
        }
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
    
    func getJobCount(status: JobStatus) -> Int {
        return self.viewModel.allJobs?.filter({$0.status == status}).count ?? 0
    }
    
    func getInvoiceCount(status: InvoiceStatus) -> Int {
        var totalSum = 0
        let invoiceList = viewModel.allInvoiceList?.filter({$0.status == status})
        invoiceList?.forEach { number in
            totalSum += number.total
        }
        return totalSum
    }
    
    func displayJobName(status: JobStatus) -> String {
        switch status {
        case .yetToStart:
            return "Yet to Start (\(getJobCount(status: status)))"
        case .inProgress:
            return "In Progress (\(getJobCount(status: status)))"
        case .canceled:
            return "Canceled (\(getJobCount(status: status)))"
        case .completed:
            return "Completed (\(getJobCount(status: status)))"
        case .incomplete:
            return "Incomplete (\(getJobCount(status: status)))"
        }
    }
    
    func displayInvoiceRole(status: InvoiceStatus) -> String {
        switch status {
        case .draft:
            return "Draft (\(dollerFormat(number: getInvoiceCount(status: status))))"
        case .badDebt:
            return "Bad debt (\(dollerFormat(number: getInvoiceCount(status: status))))"
        case .pending:
            return "Pending (\(dollerFormat(number: getInvoiceCount(status: status))))"
        case .paid:
            return "Paid (\(dollerFormat(number: getInvoiceCount(status: status))))"
        }
    }
    
    func jobColor(status: JobStatus) -> String {
        if status == .completed {
            return DashboardAssessmentColor.completedStatus.rawValue
        } else if status == .incomplete {
            return DashboardAssessmentColor.incompleteStatus.rawValue
        } else if status == .yetToStart {
            return DashboardAssessmentColor.yettostartStatus.rawValue
        } else if status == .canceled {
            return DashboardAssessmentColor.cancelledStatus.rawValue
        } else if status == .inProgress {
            return DashboardAssessmentColor.inprogressStatus.rawValue
        } else {
            return DashboardAssessmentColor.completedStatus.rawValue
        }
    }
    
    func invoiceColor(status: InvoiceStatus) -> String {
        if status == .paid {
            return DashboardAssessmentColor.completedStatus.rawValue
        } else if status == .draft {
            return DashboardAssessmentColor.cancelledStatus.rawValue
        } else if status == .pending {
            return DashboardAssessmentColor.inprogressStatus.rawValue
        } else if status == .badDebt {
            return DashboardAssessmentColor.incompleteStatus.rawValue
        } else {
            return DashboardAssessmentColor.completedStatus.rawValue
        }
        
    }
}

#Preview {
    CharHighlightView()
}
