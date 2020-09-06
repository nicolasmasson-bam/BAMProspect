//
//  Logging.swift
//  BAMProspect
//
//  Created by Nicolas Masson on 06/09/2020.
//  Copyright © 2020 BAM. All rights reserved.
//

import Foundation
import XCGLogger

let logIdentifier = "tech.bam.log"
let log = XCGLogger(identifier: logIdentifier)

func setupLogging() {
    let logLevel: XCGLogger.Level = .verbose // To adjust for release with macro

    log.setup(level: logLevel, showLogIdentifier: true, showFunctionName: true,
              showThreadName: true, showLevel: true, showFileNames: true,
              showLineNumbers: true, showDate: true, writeToFile: nil, fileLevel: logLevel)

    if let consoleDestination = log.destinations.first as? ConsoleDestination {
        consoleDestination.logQueue = XCGLogger.logQueue
    }
}
