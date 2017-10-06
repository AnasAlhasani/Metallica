//
//  AlbumView.swift
//  Metallica
//
//  Created by Anas on 9/26/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

class AlbumView: UIView {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }

    var album: Album? {
        didSet{
            if let album = album {
                imageView.image = album.image
                titleLabel.text = album.title
                dateLabel.text = album.date
            }
        }
    }
    
    private func prepareForAnimation(viewWidth width: CGFloat) {
        imageView.center.x  += width
        titleLabel.center.x += width
        dateLabel.center.x += width
    }

    func setViewsHidden(_ isHidden: Bool) {
        imageView.isHidden = isHidden
        titleLabel.isHidden = isHidden
        dateLabel.isHidden = isHidden
    }
    
    func startAnimation(direction: ScrollDirection) {
        
        let viewWidth = direction == .right ? bounds.width: -bounds.width
        setViewsHidden(false)
        prepareForAnimation(viewWidth: viewWidth)
        
        UIView.animate(withDuration: 0.6) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.imageView.center.x -= viewWidth
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: [], animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.titleLabel.center.x -= viewWidth
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.3, options: [], animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.dateLabel.center.x -= viewWidth
        }, completion: nil)
        

    }

}
