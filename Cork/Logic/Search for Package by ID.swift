//
//  Search for Package by ID.swift
//  Cork
//
//  Created by David Bureš on 04.07.2022.
//

import Foundation

// MARK: - Search Results
private enum PackageRetrievalByUUIDError: Error
{
    case couldNotfindAnypackagesInTracker
}

extension SearchResultTracker
{
    func getPackageFromUUID(_ requestedUUID: UUID) throws -> BrewPackage
    {
        var filteredPackage: BrewPackage?
        
        AppConstants.logger.log("Formula tracker: \(self.foundFormulae.count)")
        AppConstants.logger.log("Cask tracker: \(self.foundCasks.count)")
        
        if self.foundFormulae.count != 0
        {
            filteredPackage = self.foundFormulae.filter({ $0.id == requestedUUID }).first
        }
        
        if filteredPackage == nil
        {
            filteredPackage = self.foundCasks.filter({ $0.id == requestedUUID }).first
        }
        
        if let filteredPackage
        {
            return filteredPackage
        }
        else
        {
            throw PackageRetrievalByUUIDError.couldNotfindAnypackagesInTracker
        }
    }
}

// MARK: - Top Packages
enum TopPackageRetrievalError: Error
{
    case resultingArrayWasEmptyEvenThoughPackagesWereInIt
}

extension TopPackagesTracker
{
    func getPackageFromUUID(_ requestedUUID: UUID, isCask: Bool) throws -> BrewPackage
    {
        if !isCask
        {
            guard let foundTopFormula: TopPackage = self.topFormulae.filter({ $0.id == requestedUUID }).first else
            {
                throw TopPackageRetrievalError.resultingArrayWasEmptyEvenThoughPackagesWereInIt
            }
            
            return BrewPackage(name: foundTopFormula.packageName, isCask: isCask, installedOn: nil, versions: [], sizeInBytes: nil)
        }
        else
        {
            guard let foundTopCask: TopPackage = self.topCasks.filter({ $0.id == requestedUUID }).first else
            {
                throw TopPackageRetrievalError.resultingArrayWasEmptyEvenThoughPackagesWereInIt
            }
            
            return BrewPackage(name: foundTopCask.packageName, isCask: isCask, installedOn: nil, versions: [], sizeInBytes: nil)
        }
    }
}
