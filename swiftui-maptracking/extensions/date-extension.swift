//
//  date-extension.swift
//  assign4
//
//  Created by Adil Anwer on 29/04/2021.
//

import Foundation

extension Date {
    var completeDateTime :String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "dd MMMM yyyy h:mm a"
        return dateFormatter.string(from: self)
    }
}
