//
//  TabBarController.swift
//  Unit4Assessment
//
//  Created by Liubov Kaper  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var cardsVC: CardsViewController = {
        let viewController = CardsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "1.circle"), tag: 0)
       // viewController.dataPersistance = dataPersistance
        return viewController
    }()
    
    private lazy var createCardVC: CreateCardViewController = {
        let viewController = CreateCardViewController()
        viewController.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "2.circle"), tag: 1)
       // viewController.dataPersistance = dataPersistance
        return viewController
    }()
    
    private lazy var searchCardVC: SearchCardsViewController = {
        let viewController = SearchCardsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "3.circle"), tag: 2)
       // viewController.dataPersistance = dataPersistance
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [UINavigationController(rootViewController: cardsVC), UINavigationController(rootViewController: createCardVC), UINavigationController(rootViewController: searchCardVC)]
      
    }
    

   

}
