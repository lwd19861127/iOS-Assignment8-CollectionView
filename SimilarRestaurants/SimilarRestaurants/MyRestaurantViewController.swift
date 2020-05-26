//
//  MyRestaurantViewController.swift
//  SimilarRestaurants
//
//  Created by WendaLi on 2020-05-25.
//  Copyright © 2020 WendaLi. All rights reserved.
//

import UIKit

class MyRestaurantViewController: UIViewController {
    enum CollectionViewTag: Int {
        case restaurant
        case category
    }
    private let padding: CGFloat = 8
    
    var categoryCollectionView: UICollectionView!
    private var categories: [String] = Restaurant.Category.allCases.map {$0.rawValue}
    private var categoryIsSelected: [Bool]!

    var restaurantCollectionView: UICollectionView!
    private var restaurants: [Restaurant] = Restaurant.restaurants()
    private var filteredRestaurants: [Restaurant] = []
    
    private var isFiltering: Bool {
        return categoryIsSelected.contains(true)
    }
    
    override func loadView() {
        super.loadView()
    
        let categoryLayout = UICollectionViewFlowLayout()
        categoryLayout.scrollDirection = .horizontal
        categoryLayout.minimumInteritemSpacing = padding
        categoryLayout.minimumLineSpacing = padding * 2
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout)
        categoryCollectionView.tag = CollectionViewTag.category.rawValue
        
        let restaurantLayout = UICollectionViewFlowLayout()
        restaurantLayout.scrollDirection = .vertical
        restaurantLayout.minimumInteritemSpacing = padding
        restaurantLayout.minimumLineSpacing = padding * 2
        restaurantCollectionView = UICollectionView(frame: .zero, collectionViewLayout: restaurantLayout)
        restaurantCollectionView.tag = CollectionViewTag.restaurant.rawValue
        
        let stackView = UIStackView(arrangedSubviews: [categoryCollectionView, restaurantCollectionView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        view.addSubview(stackView)
        stackView.matchParent()
        
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        categoryCollectionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        categoryCollectionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        categoryCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        categoryIsSelected = [Bool](repeating: false, count: categories.count)
        navigationItem.title = "MyRestaurant"
        
        // Do any additional setup after loading the view.
        categoryCollectionView.backgroundColor = .systemGroupedBackground
        categoryCollectionView.contentInset = .init(top: 0, left: 18, bottom: 0, right: 18)
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        restaurantCollectionView.backgroundColor = .systemGroupedBackground
        restaurantCollectionView.contentInset = .init(top: 0, left: 18, bottom: 0, right: 18)
        restaurantCollectionView.register(MyRestaurantsCollectionViewCell.self, forCellWithReuseIdentifier: "restaurantCell")
        restaurantCollectionView.dataSource = self
        restaurantCollectionView.delegate = self
    }
    
    private func filterRestaurantFor() {
        filteredRestaurants = restaurants.filter { (restaurant) in
            var isCategoryMatching = false
            for (index, isCategorySelected) in categoryIsSelected.enumerated() {
                if isCategorySelected {
                    if index == 0 {
                        isCategoryMatching = true
                        break
                    }
                    if restaurant.category.rawValue == categories[index] {
                        isCategoryMatching = true
                    }
                }
            }
            return isCategoryMatching
        }
        restaurantCollectionView.reloadData()
    }
}

extension MyRestaurantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case CollectionViewTag.restaurant.rawValue:
            return isFiltering ? filteredRestaurants.count : restaurants.count
        case CollectionViewTag.category.rawValue:
            return categories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case CollectionViewTag.restaurant.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! MyRestaurantsCollectionViewCell
            let restaurant = isFiltering ? filteredRestaurants[indexPath.row] : restaurants[indexPath.row]
            cell.imageView.image = UIImage(named: restaurant.image)
            cell.nameLabel.text = restaurant.name
            cell.priceLabel.text = "$$"
            cell.categoryLabel.text = restaurant.category.rawValue
            return cell
        case CollectionViewTag.category.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            let category = categories[indexPath.row]
            cell.categoryLable.text = category
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
}

extension MyRestaurantViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case CollectionViewTag.restaurant.rawValue:
            let size = (collectionView.frame.width - 2 * padding) / 2.2
            return CGSize(width: size, height: size)
        case CollectionViewTag.category.rawValue:
            let widthSize = (collectionView.frame.width - 2 * padding) / 5
            let heightSize = (collectionView.frame.width - 2 * padding) / 10
            return CGSize(width: widthSize, height: heightSize)
        default:
            return CGSize()
        }
        
    }
}

extension MyRestaurantViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == CollectionViewTag.category.rawValue {
            if let curCell = collectionView.cellForItem(at: indexPath) {
                if categoryIsSelected[indexPath.row] {
                    curCell.contentView.backgroundColor = .white
                    categoryIsSelected[indexPath.row] = false
                }else {
                    curCell.contentView.backgroundColor = .orange
                    categoryIsSelected[indexPath.row] = true
                }
                filterRestaurantFor()
            }
        }
    }
}

