//
//  Get Installed Casks Intent.swift
//  Cork
//
//  Created by David Bureš on 25.05.2024.
//

import AppIntents
import Foundation

struct GetInstalledCasksIntent: AppIntent
{
    static let title: LocalizedStringResource = "intent.get-installed-casks.title"
    static let description: LocalizedStringResource = "intent.get-installed-casks.description"
    
    static let isDiscoverable: Bool = true
    static let openAppWhenRun: Bool = false
    
    func perform() async throws -> some ReturnsValue<[MinimalHomebrewPackage]>
    {
        let allowAccessToFile = AppConstants.brewCaskPath.startAccessingSecurityScopedResource()
        
        if allowAccessToFile
        {
            let installedFormulae = await loadUpPackages(whatToLoad: .cask, appState: AppState())
            
            AppConstants.brewCaskPath.stopAccessingSecurityScopedResource()
            
            let minimalPackages: [MinimalHomebrewPackage] = installedFormulae.map { package in
                return .init(name: package.name, type: .cask, installDate: package.installedOn, installedIntentionally: true)
            }
            
            return .result(value: minimalPackages)
        }
        else
        {
            print("Could not obtain access to folder")
            
            throw FolderAccessingError.couldNotObtainPermissionToAccessFolder
        }
    }
}
