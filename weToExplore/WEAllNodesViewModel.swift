//
//  WEAllNodesViewModel.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/3/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import Foundation

protocol AllNodesViewModelProtocol {
    var nodeArray: Array<String>? {get}
    var nodeArrayDidChange: ((AllNodesViewModelProtocol)-> ())? {get set}
    init(dataManager: WEDataManager)
    func updateNodes()
}

class AllNodesViewModel: AllNodesViewModelProtocol {
    let dataManager:WEDataManager
    
    var nodeArray: Array<String>?{
        didSet {
            self.nodeArrayDidChange?(self)
        }
    }
    var nodeArrayDidChange: ((AllNodesViewModelProtocol) -> ())?
    
    required init(dataManager: WEDataManager) {
        self.dataManager = dataManager;
    }
    
    func updateNodes() {
        self.dataManager.getAllNodeSuccess({ (nodeJSON:[AnyObject]!) in
            
        }) { (error: NSError!) in
                NSLog("%@", error)
        }
    }
    
}