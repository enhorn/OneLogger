//
//  File.swift
//  
//
//  Created by Robin Enhorn on 2022-06-19.
//

import Foundation

extension Error {

    func message(using errorFormatters: [OneLoggerErrorFormatter]) -> String {
        for formatter in errorFormatters {
            if let message = formatter.format(self) {
                return message
            }
        }

        return "\(self)"
    }

}
