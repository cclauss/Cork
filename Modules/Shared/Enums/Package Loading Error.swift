//
//  Package Loading Error.swift
//  CorkShared
//
//  Created by David Bureš on 30.07.2024.
//

import Foundation
import SwiftUI

enum PackageLoadingError: Error
{
    case failedWhileLoadingPackages(failureReason: LocalizedStringKey?), failedWhileLoadingCertainPackage(String, URL), packageDoesNotHaveAnyVersionsInstalled(String), packageIsNotAFolder(String, URL)
}
