//
//  categoryCollectionViewCell.swift
//  SimilarRestaurants
//
//  Created by WendaLi on 2020-05-26.
//  Copyright © 2020 WendaLi. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    let categoryLable: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = .systemBlue
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(categoryLable)
        categoryLable.matchParent(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
