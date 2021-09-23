//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Magic Keegan on 9/17/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor,
                               UIColor.yellow.cgColor,
                               UIColor.green.cgColor,
                               UIColor.blue.cgColor]
        gradientLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        
        view.addSubview(gradientLayer)
//        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150)
//        let firstView = UIView(frame: firstFrame)
//        firstView.backgroundColor = .blue
//        
//        let secondFrame = CGRect(x: 20, y: 30, width: 50, height: 50)
//        let secondView = UIView(frame: secondFrame)
//        secondView.backgroundColor = .green
//        
//        firstView.addSubview(secondView)
//        view.addSubview(firstView)
        
        
        
//        view.addSubview(secondView)
        // Do any additional setup after loading the view.
    }


}

