//
//  Cached Download.swift
//  Cork
//
//  Created by David Bureš on 04.11.2023.
//

import Foundation
import SwiftUI
import Charts

public struct CachedDownload: Identifiable, Hashable
{
    public var id: UUID = UUID()

    let packageName: String
    let sizeInBytes: Int
    
    var packageType: CachedDownloadType?
}
