//
//  HomeTabVM.swift
//  LibrariesManagerWithKMP
//
//  Created by sangavi-15083 on 13/06/25.
//

import Combine
import KMPLibrariesManager

enum UIState {
    case loading
    case success([Library])
    case error(String)
}

class HomeTabVM: ObservableObject {

    @Published private(set) var uiState: UIState = .loading
    
    func fetchLibraries() {
        self.uiState = .loading

        DispatchQueue.global(qos: .background).async {
            do {
                let libraries = try dataSource.getAllLibraries()
                DispatchQueue.main.async {
                    self.uiState = .success(libraries)
                }
            } catch {
                DispatchQueue.main.async {
                    self.uiState = .error(NSLocalizedString("common_unknown_error", comment: "Unknown error occurred"))
                }
            }
        }
    }
    
}

