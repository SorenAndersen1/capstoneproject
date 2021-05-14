//
//  LibraryCollectionCell.swift
//  WalkThru
//
//  Created by user183837 on 5/13/21.
//

import UIKit

class LibraryCollectionCell: UICollectionViewCell {
    var starRating: Int = 1
    @IBOutlet weak var fiveStarButton: UIButton!
    @IBOutlet weak var fourStarButton: UIButton!
    @IBOutlet weak var threeStarButton: UIButton!
    @IBOutlet weak var twoStarButton: UIButton!
    @IBOutlet weak var oneStarButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var instructSelectButton: UIButton!
}
