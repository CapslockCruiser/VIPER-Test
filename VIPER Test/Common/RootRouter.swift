//
//  RootRouter.swift
//  VIPER Test
//
//  Created by William Choi on 6/10/18.
//  Copyright © 2018 William Choi. All rights reserved.
//

import UIKit

final class RootRouter: RootWireframe {
    
    private var environment: Environment
    
    init(environment: Environment = .development) {
        self.environment = environment
    }
    
    func presentAchievementScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = AchievementsRouter.createModule(environment: environment)
    }
}

protocol RootWireframe: class {
    func presentAchievementScreen(in window: UIWindow)
}
