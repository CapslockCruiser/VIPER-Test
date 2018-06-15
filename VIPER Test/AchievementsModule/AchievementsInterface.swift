//
//  AchievementsInterface.swift
//  VIPER Test
//
//  Created by William Choi on 6/10/18.
//  Copyright © 2018 William Choi. All rights reserved.
//

import UIKit

protocol AchievementsViewToPresenterProtocol: class {
    var view: AchievementsPresenterToViewProtocol? { get set }
    var interactor: AchievementsPresenterToInteractorProtocol? { get set }
    var router: AchievementsPresenterToRouterProtocol?  { get set }
    func requestUpdate()
    func setupView()
}

protocol AchievementsPresenterToViewProtocol: class {
    func setupView(navTitle: String)
    func showAchievements(_ achievementsViewModels: [AchievementViewModel])
}

protocol AchievementsPresenterToInteractorProtocol: class {
    func retrieveAchievements(success: (([Achievement]) -> Void))
    func retrieveImage(url: URL) -> UIImage?
}

protocol AchievementsInteractorToPresenterProtocol: class {
    var interactor: AchievementsPresenterToInteractorProtocol? { get set }
    func achievementsDidUpdate(achievements: [Achievement])
//    func achievementsVMDidUpdate()
}

protocol AchievementsPresenterToRouterProtocol: class {
    static func createModule(environment: Environment) -> UIViewController
}

protocol AchievementsRouterToPresenterProtocol: class {
    
}
