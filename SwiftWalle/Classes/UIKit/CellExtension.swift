//
//  CellExtension.swift
//  SwiftWalle
//
//  Created by Don.shen on 2020/5/16.
//

import UIKit
/// Access a reuseIdentifeir directly form the UITableViewCell or UICollectionCell subclass:
/// eg: tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier())
protocol ReuseIdentifiable {
    static func reuseIdentifier() -> String
}

extension ReuseIdentifiable  {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}

extension UICollectionViewCell: ReuseIdentifiable {}
