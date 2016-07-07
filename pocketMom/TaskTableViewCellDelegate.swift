//
//  IndexPath.swift
//  pocketMom
//
//  Created by Sung Kim on 7/7/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import Foundation

protocol TaskTableViewCellDelegate: class {
    
    func didFinishDeletion(indexPath: NSIndexPath)
    
}