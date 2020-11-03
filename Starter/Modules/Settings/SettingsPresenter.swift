//
//  HomePresenter.swift
//  Starter
//
//  Created by Mark Webb on 14/10/2020.
//

import Foundation

protocol SettingsPresentationLogic: class {

}

extension Settings {
    class Presenter: SettingsPresentationLogic {
        var viewController: SettingsDisplayLogic!
    }
}
