//
//  HomeRouter.swift
//  Starter
//
//  Created by Mark Webb on 14/10/2020.
//

import UIKit

protocol SettingsRoutingLogic: class {

}

extension Settings {
    class Router: SettingsRoutingLogic {
        weak var viewController: ViewController!
    }
}

extension Settings.Router: Displayable {
    func setupDisplayable() -> UIViewController {
        let viewController = Settings.ViewController()
        let interactor = Settings.Interactor()
        let presenter = Settings.Presenter()

        self.viewController = viewController
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = self

        return self.viewController
    }

    var viewControllerType: UIViewController.Type {
        Settings.ViewController.self
    }
}
