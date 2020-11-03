//
//  HomeViewController.swift
//  Starter
//
//  Created by Mark Webb on 14/10/2020.
//

import UIKit
import UIComponents

protocol HomeDisplayLogic: class {

}

extension Home {
    class ViewController: StackViewController, HomeDisplayLogic {
        weak var interactor: HomeBusinessLogic!
        var router: HomeRoutingLogic!

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            stackView.removeAllRows()

            stackView.addRow(
                UILabel.buildH3Label {
                    $0.text = "Home"
                }
            )
        }
    }
}
