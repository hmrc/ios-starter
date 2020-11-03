//
//  TabBarController+DisplayScene.swift
//  Starter
//
//  Created by Mark Webb on 03/11/2020.
//

import UIKit

extension UITabBarController {
    func set(displayScenes: [DisplayScene]) {
        setViewControllers(displayScenes.map {
            $0.viewController
        }, animated: false)
    }
}
