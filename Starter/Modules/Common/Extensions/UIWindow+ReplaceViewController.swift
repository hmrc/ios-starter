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

import ios_core_library
import UIKit

extension UIWindow {
    func replaceRootViewController(_ newRootViewController: UIViewController, animated: Bool = true, complete: VoidHandler? = nil) {
        let window = UIWindow.mainWindow

        let replaceRoot = {
            window.rootViewController = newRootViewController
            window.makeKeyAndVisible()
        }

        guard animated, let snapshot = window.snapshotView(afterScreenUpdates: true) else {
            replaceRoot()
            return
        }
        let animations: () -> Void = {
            snapshot.removeFromSuperview()
            replaceRoot()
        }
        window.addSubview(snapshot)
        _ = newRootViewController.view // create view
        UIView.transition(
            with: window,
            duration: 0.3,
            options: UIView.AnimationOptions.transitionFlipFromRight,
            animations: animations,
            completion: { _ in
                complete?()
            }
        )
    }

    class var mainWindow: UIWindow {
        guard let mainWindow = UIApplication.shared.delegate?.window, let window = mainWindow else {
            Log.info(message: "Unable to find window")
            return UIWindow()
        }
        return window
    }
}
