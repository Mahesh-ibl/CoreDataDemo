//
//  ActionProtocol.swift
//  CoreDataDemo
//
//  Created by IBL INFOTECH on 04/03/21.
//  Copyright © 2021 IBL INFOTECH. All rights reserved.
//

import Foundation

protocol StudentActionDelegate {
    func onTapDelete(cell:StudentCell)
    func onTapUpdate(cell:StudentCell)
}
