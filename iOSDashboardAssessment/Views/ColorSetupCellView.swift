//
//  ColorSetupCellView.swift
//  iOSDashboardAssessment
//
//  Created by Amilzith on 21/06/24.
//

import SwiftUI
import SampleData

struct ColorSetupCellView: View {
    var allJobs: [JobApiModel]?
    var allInvoice: [InvoiceApiModel]?
    var isJobStatus = false
    
    var body: some View {
        GeometryReader { geometry in
            if isJobStatus {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(Array(JobStatus.allCases).sorted(by: { getJobCount(status: $0) > getJobCount(status: $1) }), id: \.self) { value in
                        let widthPercentage =  getJobCount(status: value) / CGFloat(allJobs?.count ?? 0)
                        HStack(alignment: .center) {}
                            .frame(width: geometry.size.width * CGFloat(widthPercentage), height: 20)
                            .background(Color(jobColor(status: value)))
                    }
                }
                .cornerRadius(6.0)
            } else {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(Array(InvoiceStatus.allCases).sorted(by: { getInvoiceCount(status: $0) > getInvoiceCount(status: $1) }), id: \.self) { value in
                        let widthPercentage =  getInvoiceCount(status: value) / CGFloat(allInvoice?.count ?? 0)
                        HStack(alignment: .center) {}
                            .frame(width: geometry.size.width * CGFloat(widthPercentage), height: 20)
                            .background(Color(invoiceColor(status: value)))
                    }
                }
                .cornerRadius(6.0)
            }
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
    
    func getJobCount(status: JobStatus) -> CGFloat {
        return CGFloat(allJobs?.filter({$0.status == status}).count ?? 0)
    }
    
    func getInvoiceCount(status: InvoiceStatus) -> CGFloat {
        return CGFloat(allInvoice?.filter({$0.status == status}).count ?? 0)
    }
}
