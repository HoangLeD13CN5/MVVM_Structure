//
//  extentions.swift
//  MVVM_Structure
//
//  Created by Hoang Le on 1/15/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}

extension UITableView {
    func dequeueCell<T>(ofType type: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
    }
}

extension String {
    var digit: String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        let charSet = NSCharacterSet(charactersIn: "0123456789").inverted
        return simple.components(separatedBy: charSet).joined(separator: "")
    }
    
    public var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    func dateFromString(format: String) -> Date? {
        var formatter: DateFormatter
        formatter = DateFormatter()
        formatter.dateFormat = format
        if let identify = Locale.preferredLanguages.first {
            formatter.locale = Locale(identifier: identify)
        }
        return formatter.date(from: self)
    }
    
    func validateLength(size : (min : Int, max : Int)) -> Bool{
        return (size.min...size.max).contains(self.count)
    }
    
    func validateEmailPattern() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
