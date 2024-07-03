//
//  Services Fatal Errors.swift
//  Cork
//
//  Created by David Bureš on 12.05.2024.
//

import Foundation

enum ServicesFatalError: LocalizedError
{
    case couldNotLoadServices(error: String)

    case couldNotStartService(offendingService: String, errorThrown: String)
    case couldNotStopService(offendingService: String, errorThrown: String)

    case couldNotSynchronizeServices(errorThrown: String)

    var errorDescription: String?
    {
        switch self
        {
        case .couldNotLoadServices:
            return String(localized: "services.error.could-not-load-services")
        case .couldNotStartService(let offendingService, _):
            return String(localized: "services.error.could-not-start-service.\(offendingService)")
        case .couldNotStopService(let offendingService, _):
            return String(localized: "services.error.could-not-stop-service.\(offendingService)")
        case .couldNotSynchronizeServices:
            return String(localized: "services.error.could-not-synchronize-services")
        }
    }

    var failureReason: String
    {
        switch self
        {
        case .couldNotLoadServices(let error):
            return error
        case .couldNotStartService(_, let errorThrown):
            return errorThrown
        case .couldNotStopService(_, let errorThrown):
            return errorThrown
        case .couldNotSynchronizeServices(let errorThrown):
            return errorThrown
        }
    }
}
