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
import UIComponents
import UIKit

class StackView: AloeStackView {
    override init() {
        super.init()

        backgroundColor = UIColor.Semantic.pageBackground.raw
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureCell(_ cell: StackViewCell) {
        super.configureCell(cell)
        cell.layoutMargins = .init(padding: 0)
    }

    func setRows(_ rows: [UIView], animated: Bool = false, useDivider: Bool = false) {
        removeAllRows()
        var rows = rows

        if useDivider {
            rows = rows.enumerated().reduce([UIView]()) { (result, next) -> [UIView] in
                var result = result
                let offset = next.offset
                let view = next.element

                if offset == rows.count - 1 {
                    result.append(view)
                } else {
                    result.append(view)
                    result.append(makeSeparator())
                }

                return result
            }
        }

        addRows(rows, animated: false)
    }

    func setRow(_ row: UIView, animated: Bool = false) {
        removeAllRows()
        addRow(row, animated: animated)
    }

    func removeCardGroup(_ group: UIView, animated: Bool = false) {
        let rowIndex = getAllRows().firstIndex { group == $0 }
        guard let index = rowIndex else { return }
        let group = getAllRows()[index]
        let divider = getAllRows()[index + 1]

        removeRows([
            group,
            divider
        ])
    }
}

private extension StackView {
    func makeSeparator() -> UIView {
        SeparatorView(
            config: .init(
                separatorFirst: true,
                includeMiddle: false,
                includeLast: false,
                backgroundColor: .clear,
                separatorColor: UIColor.Semantic.divider.raw,
                dividerLineThickness: 1.0,
                totalThickness: 1.0,
                layoutMargins: .zero,
                createSeparator: nil
            )
        )
    }
}
