//
//  UserMessage.swift
//  BAMProspect
//
//  Created by Nicolas Masson on 06/09/2020.
//  Copyright © 2020 BAM. All rights reserved.
//

import Foundation
import SwiftMessages

enum MessageType: String {
    case error
    case info
    case warning
    case success

    func alertViewType() -> Theme {
        switch self {
        case .error:
            return .error
        case .info:
            return .info
        case .warning:
            return .warning
        case .success:
            return .success
        }
    }

    func alertViewTitle() -> String {
        switch self {
        case .error:
            return NSLocalizedString("alertView.title.error", comment: "Error")
        case .info:
            return NSLocalizedString("alertView.title.information", comment: "Information")
        case .warning:
            return NSLocalizedString("alertView.title.warning", comment: "Warning")
        case .success:
            return NSLocalizedString("alertView.title.success", comment: "Success")
        }
    }
}

class UserMessage {

    static func showGenericError() {
        let message = NSLocalizedString("error.generic.description", comment: "Unexpected error occured")
        showError(message: message)
    }

    static func showError(message: String) {
        let type: MessageType = .error

        // A message to show to user
        let view = MessageView.viewFromNib(layout: .cardView)
        // Theme message elements with the error style.
        view.configureTheme(type.alertViewType())
        // Add a drop shadow.
        view.configureDropShadow()
        view.configureContent(title: type.alertViewTitle(), body: message)
        // Hide action button
        view.button?.isHidden = true
        // Show the message.
        SwiftMessages.show(view: view)
    }

    static func show(_ type: MessageType, message: String) {
        // A message to show to user
        let view = MessageView.viewFromNib(layout: .cardView)
        // Theme message elements with the type style.
        view.configureTheme(type.alertViewType())
        // Add a drop shadow.
        view.configureDropShadow()
        view.configureContent(title: type.alertViewTitle(), body: message)
        // Hide action button
        view.button?.isHidden = true
        // Show the message.
        SwiftMessages.show(view: view)
    }
}
