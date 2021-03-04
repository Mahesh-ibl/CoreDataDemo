//
//  StudentCell.swift
//  CoreDataDemo
//
//  Created by IBL INFOTECH on 04/03/21.
//  Copyright © 2021 IBL INFOTECH. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StudentCell: UITableViewCell {
    
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldRollNumber: UITextField!
    var objectId:NSManagedObjectID?
    var studentActionDelegate:StudentActionDelegate?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        btnUpdate.isEnabled = false
        textFieldName.addTarget(self, action: #selector(onTextDidChange), for: .editingChanged)

    }
    
    @IBAction func onTapDelete(_ sender: UIButton) {
        studentActionDelegate?.onTapDelete(cell:self)
    }
    
    @IBAction func onTapUpdate(_ sender: UIButton) {
       studentActionDelegate?.onTapUpdate(cell:self)
    }
    
    @objc func onTextDidChange() {
        if textFieldName.text != "" {
            btnUpdate.isEnabled = true
        } else {
            btnUpdate.isEnabled = false
        }
    }
}
