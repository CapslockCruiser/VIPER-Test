//
//  AchievementsInteractor.swift
//  VIPER Test
//
//  Created by William Choi on 6/10/18.
//  Copyright © 2018 William Choi. All rights reserved.
//

import UIKit

final class AchievementsInteractor {
    
    weak var presenter: AchievementsInteractorToPresenterProtocol?
    private let dataManager: DataManager
    private let imageManager: ImageManager
    
    private var environment: Environment
    
    private var achievements: [Achievement] = []
    
    init(environment: Environment) {
        self.environment = environment
        dataManager = DataManager(environment: environment)
        imageManager = ImageManager(environment: environment)
    }
}

extension AchievementsInteractor: AchievementsPresenterToInteractorProtocol {
    
    func retrieveAchievements(success: (([Achievement]) -> Void)) {
        dataManager.retrieveAchievements() { achievements in
            self.achievements = achievements
            success(achievements)
        }
    }
    
    func retrieveImage(url: URL) -> UIImage? {
        if let image = imageManager.checkImage(url: url) {
            return image
        } else {
            imageManager.retrieveImage(url: url) { [weak self] image in
                guard let strongSelf = self else { return }
                strongSelf.presenter?.achievementsDidUpdate(achievements: strongSelf.achievements)
            }
            return nil
        }
    }
    
}

final class AchievementViewModel {
    let level: String
    let progress: Int
    let total: Int
    var image: UIImage?
    let accessible: Bool
    
    init(achievement: Achievement) {
        self.level = achievement.level
        self.progress = achievement.progress
        self.total = achievement.total
        self.accessible = achievement.accessible

    }
}
