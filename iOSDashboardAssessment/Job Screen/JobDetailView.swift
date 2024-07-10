//
//  JobDetailView.swift
//  iOSDashboardAssessment
//
//  Created by Amilzith on 21/06/24.
//

import SwiftUI
import SampleData

struct JobDetailView: View {
    var job: JobApiModel?
    var geometry: GeometryProxy?
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text("#\(job?.jobNumber ?? 0)")
                    .font(.system(size: (geometry?.size.width ?? 0.0) * 0.040))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("\(job?.title ?? "")")
                    .font(.system(size: (geometry?.size.width ?? 0.00) * 0.040))
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                Text("\(convertDateFormat(from: job?.startTime ?? "")) -> \(convertDateFormat(from: job?.endTime ?? ""))")
                    .font(.system(size: (geometry?.size.width ?? 0.00) * 0.030))
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                
            }
            .padding(.leading, (geometry?.size.width ?? 0.0) * 0.030)
            Spacer()
        }
        .padding([.top, .bottom], (geometry?.size.width ?? 0) * 0.04)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5).foregroundColor(Color.gray))
        .background(Color.white)
        .cornerRadius(10)
        .padding([.leading, .trailing], (geometry?.size.width ?? 0) * 0.05)
        
    }
    
    
    func convertDateFormat(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        

        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid date"
        }
    }
}

#Preview {
    JobDetailView()
}


