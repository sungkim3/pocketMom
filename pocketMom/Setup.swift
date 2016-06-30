//
//  Setup.swift
//  pocketMom
//
//  Created by Sung Kim on 6/30/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import Foundation

protocol Setup {
    static var id: String { get }
    func setup()
    func setupAppearance()
}

extension Setup {
    static var id: String {
        return String(self)
    }
}