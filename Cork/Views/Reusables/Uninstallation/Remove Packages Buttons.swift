//
//  Remove Packages Buttons.swift
//  Cork
//
//  Created by David Bureš on 02.04.2024.
//

import SwiftUI

struct UninstallPackageButton: View
{
    let package: BrewPackage

    let isCalledFromSidebar: Bool

    var body: some View
    {
        RemovePackageButton(package: package, shouldPurge: false, isCalledFromSidebar: isCalledFromSidebar)
    }
}

struct PurgePackageButton: View
{
    let package: BrewPackage

    let isCalledFromSidebar: Bool

    var body: some View
    {
        RemovePackageButton(package: package, shouldPurge: true, isCalledFromSidebar: isCalledFromSidebar)
    }
}

private struct RemovePackageButton: View
{
    @AppStorage("shouldRequestPackageRemovalConfirmation") var shouldRequestPackageRemovalConfirmation: Bool = false

    @EnvironmentObject var brewData: BrewDataStorage
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var outdatedPackageTracker: OutdatedPackageTracker

    @EnvironmentObject var uninstallationConfirmationTracker: UninstallationConfirmationTracker

    let package: BrewPackage

    let shouldPurge: Bool
    let isCalledFromSidebar: Bool

    var body: some View
    {
        Button(role: .destructive)
        {
            if !self.shouldRequestPackageRemovalConfirmation
            {
                Task
                {
                    AppConstants.logger.debug("Confirmation of package removal NOT needed")

                    try await self.brewData.uninstallSelectedPackage(
                        package: self.package,
                        appState: self.appState,
                        outdatedPackageTracker: self.outdatedPackageTracker,
                        shouldRemoveAllAssociatedFiles: self.shouldPurge,
                        shouldApplyUninstallSpinnerToRelevantItemInSidebar: self.isCalledFromSidebar
                    )
                }
            }
            else
            {
                AppConstants.logger.debug("Confirmation of package removal needed")
                self.uninstallationConfirmationTracker.showConfirmationDialog(packageThatNeedsConfirmation: self.package, shouldPurge: self.shouldPurge, isCalledFromSidebar: self.isCalledFromSidebar)
            }
        } label: {
            Text(self.shouldPurge ? "action.purge-\(self.package.name)" : "action.uninstall-\(self.package.name)")
        }
    }
}
