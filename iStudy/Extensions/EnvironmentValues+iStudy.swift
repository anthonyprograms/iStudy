//
//  EnvironmentValues+iStudy.swift
//  iStudy
//
//  Created by Anthony Williams on 3/23/24.
//

import SwiftUI

extension EnvironmentValues {
    var persistenceManager: PersistenceManager {
        get { self[PersistenceManagerKey.self] }
        set { self[PersistenceManagerKey.self] = newValue }
    }
}
