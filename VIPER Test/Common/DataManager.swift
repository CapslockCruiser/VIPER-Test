//
//  DataManager.swift
//  VIPER Test
//
//  Created by William Choi on 6/10/18.
//  Copyright © 2018 William Choi. All rights reserved.
//

import Foundation

final class DataManager {
    
    private var environment: Environment
    private let imageManager: ImageManager
    
    init(environment: Environment = .development) {
        self.environment = environment
        imageManager = ImageManager(environment: environment)
    }
    
    func retrieveAchievements(success: ([Achievement]) -> Void) {
        switch environment {
        case .development:
            let bundle = Bundle(for: type(of: self))
            
            guard let dataPath = bundle.path(forResource: "achievements", ofType: ".json") else { return }
            guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: dataPath)) else { return }
            guard let decodedAch = try? JSONDecoder().decode(DecodedAchievements.self, from: jsonData) else { return }
            
            success(decodedAch.achievements)
        case .production:
            //Retrieve from actual server
            break
        }
    }
    
}

private struct DecodedAchievements: Decodable {
    let achievements: [Achievement]
    let success: Bool
    let status: Int
}
