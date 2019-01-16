//
//  AutoSizeConstraint.swift
//  OnePay
//
//  Created by Quang Anh on 1/6/18.
//  Copyright © 2018 Quang Anh. All rights reserved.
//

import UIKit

class AutoSizeConstraint: NSLayoutConstraint {
    override func awakeFromNib() {
        super.awakeFromNib()
        let ratio = UIScreen.main.bounds.width/375
        self.constant = self.constant*(ratio < 1.5 ? ratio : 1.5)
    }
}
