//
//  UIViewExtention.swift
//  Metallica
//
//  Created by Anas on 9/26/17.
//  Copyright © 2017 Anas Alhasani. All rights reserved.
//

import UIKit

protocol ViewIdentifiable {
    static var nibName: String { get }
}

extension ViewIdentifiable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UIView: ViewIdentifiable {
    static func create() -> Self {
        return instantiateView()
    }
    
    private static func instantiateView<T: UIView>() -> T {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError("Couldn't instantiate view with identifier \(T.nibName)")
        }
        return view
    }
}

