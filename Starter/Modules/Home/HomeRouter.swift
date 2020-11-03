//
//  HomeRouter.swift
//  Starter
//
//  Created by Mark Webb on 14/10/2020.
//

import UIKit

protocol HomeRoutingLogic: class {

}

extension Home {
    class Router: HomeRoutingLogic {
        weak var viewController: ViewController!
    }
}

extension Home.Router: Displayable {
    func setupDisplayable() -> UIViewController {
        let viewController = Home.ViewController()
        let interactor = Home.Interactor()
        let presenter = Home.Presenter()

        self.viewController = viewController
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = self

        return self.viewController
    }

    var viewControllerType: UIViewController.Type {
        Home.ViewController.self
    }
}
