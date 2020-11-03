/*
 * Copyright 2020 HM Revenue & Customs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import AloeStackView
import UIKit

class StackViewController: UIViewController {
    // MARK: Vars

    var isInProcessOfTransitioningView = false

    private var defaultContentInset: UIEdgeInsets = .zero {
        didSet {
            updateContentInset(with: defaultContentInset)
        }
    }

    private var keyboardTopMargin: CGFloat = 20

    // MARK: Lifecycle

     override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func loadView() {
        super.loadView()
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if automaticallyFlashScrollIndicators {
            stackView.flashScrollIndicators()
        }

        addObservers()
    }

    let stackView: StackView = StackView.build {
        $0.automaticallyHidesLastSeparator = true
        $0.separatorInset = .zero
        $0.separatorHeight = 0
    }

    open var automaticallyFlashScrollIndicators = false

    func retryReloadAfter5XX() {
        fatalError("Subclass must override retry reload after 5XX")
    }

    func didDisplayShutteringView() {
        // To be subclassed if needed
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        isInProcessOfTransitioningView = true
        coordinator.animate(alongsideTransition: nil) { _ in
            self.isInProcessOfTransitioningView = false
        }
    }
}

// Keyboard Observer Methods
private extension StackViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        guard var keyboardFrame = keyboardFrameValue?.cgRectValue else { return }
        keyboardFrame = stackView.convert(keyboardFrame, from: nil)
        let keyboardSize = keyboardFrame.size

        let bottomInset = keyboardSize.height + keyboardTopMargin
        let keyboardInset = UIEdgeInsets(
            top: defaultContentInset.top,
            left: defaultContentInset.left,
            bottom: bottomInset,
            right: defaultContentInset.right
        )

        updateContentInset(with: keyboardInset)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        updateContentInset(with: defaultContentInset)
    }

    // MARK: Helpers

    private func updateContentInset(with inset: UIEdgeInsets) {
        stackView.contentInset = inset
        stackView.scrollIndicatorInsets = inset
    }

    private func addObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self, selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        notificationCenter.addObserver(
            self, selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
}
