//
//  HomeViewController.swift
//  Starter
//
//  Created by Mark Webb on 14/10/2020.
//

import UIKit
import UIComponents

protocol SettingsDisplayLogic: class {

}

extension Settings {
    class ViewController: StackViewController, SettingsDisplayLogic {
        weak var interactor: SettingsBusinessLogic!
        var router: SettingsRoutingLogic!

        override init() {
            super.init()
            title = "Settings"
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            stackView.removeAllRows()

            stackView.addRow(
                UILabel.buildH3Label {
                    $0.text = "Settings"
                }
            )
        }
    }
}
