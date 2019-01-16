//
//  AutoSizeLabel.swift
//  OnePay
//
//  Created by Quang Anh on 1/2/18.
//  Copyright © 2018 Quang Anh. All rights reserved.
//

import UIKit

class AutoSizeLabel: UILabel {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let ratio = UIScreen.main.bounds.width/375
        if ratio < 1.0 {
            if let size = self.font?.pointSize {
                self.font = self.font?.withSize(size*ratio)
            }
        }
    }
}
