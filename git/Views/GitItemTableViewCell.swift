//
//  GitItemTableViewCell.swift
//  git
//
//  Created by mostfa on 12/9/19.
//  Copyright © 2019 mostfa. All rights reserved.
//

import UIKit
import MarqueeLabel

class GitItemTableViewCell: UITableViewCell {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var textBackView: UIView!
    @IBOutlet weak var rpeoName: MarqueeLabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var forksNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
            textBackView.backgroundColor = .white
               textBackView.clipsToBounds = true
              textBackView.layer.cornerRadius = 15
              textBackView.addShadow(offset: CGSize(width: -6, height: -5), color: .black, radius: 3, opacity: 0.1)
              backImage.layer.cornerRadius = 25
              backImage.layer.masksToBounds = true
              
              backImage.addShadow(offset: CGSize(width: 6, height: -5), color: .black, radius: 3, opacity: 0.1)
        
    }

    
  
    func configureForRepo(with name:String, description:String,forkNumber:Int,date:String,language:String?){
      
        rpeoName.text = name
        repoDescription.text = description
        forksNumber.text = String(forkNumber)
        let languageString = language != nil ? " 💻: Written in \(language!)" : "language not specified 😭"
        repoDescription.text =  repoDescription.text! + " \n 🗓: Was created at \(date) \n" + languageString

        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
