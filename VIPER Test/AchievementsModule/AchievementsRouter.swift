//
//  AchievementsRouter.swift
//  VIPER Test
//
//  Created by William Choi on 6/10/18.
//  Copyright © 2018 William Choi. All rights reserved.
//

import UIKit

final class AchievementsRouter {
    var viewController: UIViewController?
}

extension AchievementsRouter: AchievementsPresenterToRouterProtocol {
    static func createModule(environment: Environment) -> UIViewController {
        
        guard let view = UIStoryboard(name: "AchievementsStoryboard", bundle: nil).instantiateInitialViewController() as? AchievementsViewController else {
            assertionFailure(); return UIViewController()
        }
        
        let presenter = AchievementsPresenter()
        let interactor = AchievementsInteractor(environment: environment)
        let router = AchievementsRouter()
        
        
        let navigation = UINavigationController(rootViewController: view)
        navigation.navigationBar.barTintColor = UIColor(red: 105/255, green: 54/255, blue: 206/255, alpha: 1)
        navigation.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigation.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "i", style: .plain, target: nil, action: nil)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        return navigation
    }
    
    
}
