//
//  File.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/24/25.
//

import Foundation
import os

struct Log {
    private static let subsystem = "private.gwan.nntodo"

    ///
    private static let logD = Logger(subsystem: subsystem, category: "DEBUG")
    private static let logE = Logger(subsystem: subsystem, category: "ERROR")

    
    /// debug 메시지를 출력하는 편의 함수
    static func logDebug(_ message: String) {
        logD.debug("\(message)")
    }
    
    static func logDebug(_ message: String, key: String) {
        logDebug("\(key) >>> \(message)")
    }
    
    /// 오류 메시지를 출력하는 편의 함수
    static func logError(_ message: String, error: Error? = nil) {
        let m = if let error = error {
            """
            \(message)
            error:\(error.localizedDescription)
            """
        } else {
            """
            \(message)
            """
        }
        logE.error("\(m)")
    }
    
    static func logError(_ message: String, error: Error? = nil, key: String) {
        logError("\(key) >>> \(message)", error: error)
    }
}
