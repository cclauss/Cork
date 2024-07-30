//
//  Terminal Output.swift
//  Cork
//
//  Created by David Bureš on 12.02.2023.
//

import Foundation

public struct TerminalOutput: Sendable
{
    public var standardOutput: String
    public var standardError: String
}

public enum StreamedTerminalOutput
{
    case standardOutput(String)
    case standardError(String)
}
