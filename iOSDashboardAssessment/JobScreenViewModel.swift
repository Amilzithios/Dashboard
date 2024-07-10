//
//  JobScreenViewModel.swift
//  iOSDashboardAssessment
//
//  Created by Amilzith on 21/06/24.
//

import Foundation
import SampleData

class DashboardViewModel: ObservableObject {
    @Published var jobs: [JobApiModel]?
    @Published var allJobs: [JobApiModel]?
    var allInvoiceList: [InvoiceApiModel]?
    @Published var totalInvoice: Int?
    @Published var updateData: Bool = true
    
    init() {
        self.jobs = []
        self.allJobs = []
        self.allInvoiceList = []
        self.totalInvoice = 0
        getJobList(status: .yetToStart)
    }
    
    func getJobList(status: JobStatus) {
        self.allJobs = SampleData.generateRandomJobList(size: 100)
        self.jobs = allJobs?.filter({$0.status == status})
        getInvoiceList()
    }
    
    func getInvoiceList() {
        self.allInvoiceList = SampleData.generateRandomInvoiceList(size: 100)
        var totalSum = 0
        allInvoiceList?.forEach { number in
            totalSum += number.total
        }
        totalInvoice = totalSum
    }
    
    func getCollectedCount() -> Int {
        let invoices = self.allInvoiceList?.filter({$0.status == .paid})
        var totalSum = 0
        invoices?.forEach { number in
            totalSum += number.total
        }
        return totalSum
    }
    
    func getCompletedCount() -> Int {
        return self.allJobs?.filter({$0.status == .completed}).count ?? 0
    }
}
