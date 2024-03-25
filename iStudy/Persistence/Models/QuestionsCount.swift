//
//  QuestionsCount.swift
//  iStudy
//
//  Created by Anthony Williams on 3/25/24.
//

import Foundation

extension PersistenceManager {
    struct QuestionsCount {
        /// The total number of questions
        let total: Int
        /// The number of questions answered
        let answered: Int
        /// The number of questions left
        let left: Int
    }
}
