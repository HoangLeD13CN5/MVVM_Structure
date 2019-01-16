//
//  AutoSizeTextView.swift
//  Merchant
//
//  Created by Hoang Le on 11/24/18.
//  Copyright © 2018 mobile. All rights reserved.
//

import UIKit

class AutoSizeTextView: UITextView {
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

