//
//  HomePresenter.swift
//  Starter
//
//  Created by Mark Webb on 14/10/2020.
//

import Foundation

protocol HomePresentationLogic: class {

}

extension Home {
    class Presenter: HomePresentationLogic {
        var viewController: HomeDisplayLogic!
    }
}
