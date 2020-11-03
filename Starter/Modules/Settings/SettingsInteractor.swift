//
//  HomeInteractor.swift
//  Starter
//
//  Created by Mark Webb on 14/10/2020.
//

import Foundation

protocol SettingsBusinessLogic: class {
}

extension Settings {
    class Interactor: SettingsBusinessLogic {
        var presenter: SettingsPresentationLogic!
    }
}
