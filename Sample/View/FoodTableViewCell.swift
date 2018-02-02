//
//  FoodTableViewCell.swift
//  Sample
//
//  Created by Samarth Paboowal on 01/02/18.
//  Copyright © 2018 Samarth Paboowal. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FoodTableViewCell: UITableViewCell {

    var data = FoodCollection()
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupViews() {
        
        thumbnailImageView.layer.masksToBounds = true
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.size.width/2
        Alamofire.request(data.image_url!).responseImage { (downloadedImage) in
            if let image = downloadedImage.value {
                self.thumbnailImageView.image = image
            }
        }
        
        titleLabel.text = data.title!
        descriptionLabel.text = data.description!
        countLabel.text = "Restaurants count: \(data.res_count!)"
    }

}
