//
//  HomeInteractor.swift
//  Starter
//
//  Created by Mark Webb on 14/10/2020.
//

import Foundation

protocol HomeBusinessLogic: class {
}

extension Home {
    class Interactor: HomeBusinessLogic {
        var presenter: HomePresentationLogic!
    }
}
