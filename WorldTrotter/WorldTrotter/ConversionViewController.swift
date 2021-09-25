//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Magic Keegan on 9/17/21.
//

import UIKit


class ConversionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Conversion view is called")
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.red.cgColor,
//                               UIColor.yellow.cgColor,
//                               UIColor.green.cgColor,
//                               UIColor.blue.cgColor]
//        gradientLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
//        gradientLayer.frame.size = view.frame.size
//        view.layer.insertSublayer(gradientLayer,at: 0)
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

//
        
//        view.addSubview(secondView)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = UIColor(hue: CGFloat.random(in: 0...1), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
    }

}

