//
//  AchievementsPresenter.swift
//  VIPER Test
//
//  Created by William Choi on 6/10/18.
//  Copyright © 2018 William Choi. All rights reserved.
//

import UIKit

final class AchievementsPresenter {
    
    weak var view: AchievementsPresenterToViewProtocol?
    var interactor: AchievementsPresenterToInteractorProtocol?
    var router: AchievementsPresenterToRouterProtocol?
    
    var achievementsViewModels: [AchievementViewModel] = [] {
        didSet {
            if achievementsViewModels.count > 0 {
                view?.showAchievements(achievementsViewModels)
            }
        }
    }
    
    private func setAchievementVMs(achievements: [Achievement]) {
        var achVMs: [AchievementViewModel] = []
        for achievement in achievements {
            let achievementVM = AchievementViewModel(achievement: achievement)
            guard let url = URL(string: achievement.bg_image_url) else { return }
            achievementVM.image = interactor?.retrieveImage(url: url)
            achVMs.append(achievementVM)
        }
        achievementsViewModels = achVMs
    }
    
}

extension AchievementsPresenter: AchievementsViewToPresenterProtocol {
    func setupView() {
        view?.setupView(navTitle: "Smart Investing")
    }
    
    func requestUpdate() {
        interactor?.retrieveAchievements { achievements in
            setAchievementVMs(achievements: achievements)
        }
    }
    
}

extension AchievementsPresenter: AchievementsInteractorToPresenterProtocol {
    func achievementsDidUpdate(achievements: [Achievement]) {
        setAchievementVMs(achievements: achievements)
    }
    
}

extension AchievementsPresenter: AchievementsRouterToPresenterProtocol {
    
}
