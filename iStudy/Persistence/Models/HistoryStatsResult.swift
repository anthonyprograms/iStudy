//
//  HistoryStatsResult.swift
//  iStudy
//
//  Created by Anthony Williams on 3/24/24.
//

import SwiftData
import SwiftUI

extension PersistenceManager {
    enum HistoryStatsType {
        case category(Category)
        case isCorrect(Bool)
        case isCorrectAndCategory(Bool, Category)
        case none
        
        var descriptor: FetchDescriptor<History> {
            switch self {
            case let .category(category):
                let name = category.name
                return FetchDescriptor<History>(predicate: #Predicate {
                    $0.categoryName == name
                })
            case let .isCorrect(isCorrect):
                return FetchDescriptor<History>(predicate: #Predicate {
                    $0.isCorrect == isCorrect
                })
            case let .isCorrectAndCategory(isCorrect, category):
                let name = category.name
                return FetchDescriptor<History>(predicate: #Predicate {
                    $0.isCorrect == isCorrect && $0.categoryName == name
                })
            case .none:
                return FetchDescriptor<History>()
            }
        }
    }
    
    struct HistoryStatsResult {
        /// The number of questions answered correctly
        let correct: Int
        
        /// The number of questions answered
        let total: Int
    }
}
