//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Gokhan Bozkurt on 14.07.2022.
//
import CoreData
import Foundation

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    @Published var savedEntities = [PortfolioEntity]()
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading core data:\(error)")
            }
        }
        getPortfolio()
    }
    // MARK: PUBLIC
    func updatePortfolio(coin:Coin,amount: Double) {
//        if let entity = savedEntities.first(where: { savedEntity in
//            return savedEntity.coinID == coin.id
//        })
        // check if coin is already in porfolio
        if let entity = savedEntities.first(where: {  $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    //MARK: PRIVATE
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
           savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio entities.\(error)")
        }
    }
    
    private func add(coin: Coin,amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        appleyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to core data\(error)")
        }
    }
    private func appleyChanges() {
        save()
        getPortfolio()
    }
    
    private func update(entity: PortfolioEntity, amount:Double) {
        entity.amount = amount
        appleyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        appleyChanges()
    }
}
