//
//  AlbumViewController.swift
//  Metallica
//
//  Created by Anas on 9/26/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

enum ScrollDirection {
    case right
    case left
}

class AlbumViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: Injuctions
    private let albums = Album.allAlbums()
    private var albumViews: [AlbumView] = []
    private var currentPage = 0
    private var timer = Timer()
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.isEnabled = false
        pageControl.numberOfPages = albums.count
        setupScrollView()
        loadAlbumsViews()
        startTimer()
    }
    
    //MARK:  Helper Methods
    private func setupScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(albums.count), height: scrollView.bounds.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
    }
    
    private func loadAlbumsViews() {
        for (index, album) in albums.enumerated() {
            let albumView  = AlbumView.create()
            albumView.album = album
            scrollView.addSubview(albumView)
            
            albumView.frame.size.width = view.bounds.size.width
            albumView.frame.size.height = scrollView.bounds.size.height
            albumView.frame.origin.x = CGFloat(index) * view.bounds.size.width
            albumViews.append(albumView)
        }
    }
    
    //MARK: Timer
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3,
                                     target: self,
                                     selector: #selector(timerDidFire),
                                     userInfo: nil, repeats: true)
    }
    
    private func resetTimer() {
        timer.invalidate()
        startTimer()
    }
    
    @objc private func timerDidFire() {
        guard currentPage < albums.count - 1 else { return }
        currentPage += 1;
        showView(AtIndex: currentPage, withDirection: .right)
    }
    
    private func getVisibleRect(forPage page: Int) -> CGRect {
        let x = CGFloat(page) * view.bounds.size.width
        let y: CGFloat = 0
        let width = view.bounds.size.width
        let height = scrollView.bounds.size.height
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func showView(AtIndex index: Int, withDirection direction: ScrollDirection) {
        let albumView = albumViews[index]
        let rect = getVisibleRect(forPage: index)
        scrollView.scrollRectToVisible(rect, animated: false)
        albumViews.forEach({ $0.setViewsHidden(true) })
        albumView.startAnimation(direction: direction)
        pageControl.currentPage = index
        
    }
}


//MARK: - UIScrollViewDelegate
extension AlbumViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        resetTimer()
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        let direction: ScrollDirection = page > currentPage ? .right: .left
        guard page != currentPage else { return }
        currentPage = page
        showView(AtIndex: currentPage, withDirection: direction)
    }
    
}




