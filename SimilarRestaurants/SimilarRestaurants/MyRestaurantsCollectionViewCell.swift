//
//  MyRestaurantsCollectionViewCell.swift
//  SimilarRestaurants
//
//  Created by WendaLi on 2020-05-25.
//  Copyright © 2020 WendaLi. All rights reserved.
//

import UIKit

class MyRestaurantsCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        
        let namePriceStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .equalSpacing
            return stack
        }()
        
        let stackView: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [imageView, namePriceStack, categoryLabel])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .equalSpacing
            return stack
        }()
        contentView.addSubview(stackView)
        stackView.heightAnchor.constraint(equalToConstant: (contentView.frame.width)).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: (contentView.frame.width)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
