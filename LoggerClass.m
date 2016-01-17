// LoggerClass
// 
//
// IDECodeSnippetIdentifier: 1B89A308-4491-40A3-9CDC-3206249647E6
// IDECodeSnippetLanguage: Xcode.SourceCodeLanguage.Objective-C
// IDECodeSnippetUserSnippet: 1
---
title: "Logger manage class based on 'CocoaLumberjack'."
summary: "Create a SWIFT logger management class based on 'CocoaLumberjack'. Do remember to add '-DDEBUG' and '-DRELEASE' into the 'Project(NOT target)' -> 'Build Settings' -> 'Swift Compiler - Custom Flags'."
completion-scope: Class Implementation
---

import UIKit
import CocoaLumberjack

class Logger: NSObject {
    static let sharedInstance = Logger()
    
    private override init() {
#if DEBUG
        DDLog.setLevel(.Verbose, forClass: nil)
#else
        DDLog.setLevel(.Warning, forClass: nil)
#endif
    }
    
    func setup() {
        // TTY
        DDLog.addLogger(DDTTYLogger.sharedInstance())   // TTY = Xcode console
        DDTTYLogger.sharedInstance().colorsEnabled = true   // Enable colorful console ('XcodeColors' plugin is required).
        
        // ASL
        DDLog.addLogger(DDASLLogger.sharedInstance())   // ASL = Apple System Logs
        
        let fileLogger: DDFileLogger = DDFileLogger()   // File Logger
        fileLogger.rollingFrequency = 60*60*24  // 24 hours
        DDLog.addLogger(fileLogger)
    }
}
