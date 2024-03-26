//
//  ProgressChartView.swift
//  iStudy
//
//  Created by Anthony Williams on 3/24/24.
//

import SwiftUI
import Charts

/// Displays the number of correctly-answered questions in each category
struct ResultChartView: View {
    let categories: [Category]
    let history: [History]
    
    private var chartData: [ProgressChartData] {
        let data = categories.map { category in
            let correctCount = history.filter({ history in
                history.categoryName == category.name && history.isCorrect
            }).count
            return ProgressChartData(type: category.name, count: correctCount)
        }
        return data
    }
    
    var body: some View {
        Chart(chartData) { data in
            BarMark(x: .value("Number correct", data.count), y: .value("Category", data.type))
                .foregroundStyle(by: .value("Type", data.type))
                .annotation(position: .trailing) {
                    Text(String(data.count))
                        .foregroundColor(.gray)
            }
        }
        .chartLegend(.hidden)
        .chartXAxis(.hidden)
        .chartYAxis {
            AxisMarks { _ in
                AxisValueLabel()
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}

private extension ResultChartView {
    struct ProgressChartData: Identifiable, Equatable {
        let type: String
        let count: Int

        var id: String { return type }
    }
}
