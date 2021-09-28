//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Magic Keegan on 9/17/21.
//

import UIKit

class ConversionViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet var celsiusLable : UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet{
            updateCelsiusLable()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }
        else{
            return nil
        }
    }
    
    let numberFormatter : NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Conversion View is loaded.")
        updateCelsiusLable()
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.red.cgColor,
//                               UIColor.yellow.cgColor,
//                               UIColor.green.cgColor,
//                               UIColor.blue.cgColor]
//      gradientLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
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
    
    func updateCelsiusLable(){
        if let celsiusValue = celsiusValue {
            celsiusLable.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }
        else{
            celsiusLable.text = "???"
        }
        
//        if let text = textField.text,let value = Double(text){
//            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
//        }
//        else{
//            fahrenheitValue = nil
//        }
    }
    
    func textField(_ textField:UITextField,shouldChangeCharactersIn range: NSRange,replacementString string:String)->Bool{
//        print("Current text: \(String(describing: textField.text))")
//        print("Replacement text: \(string)")
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        if existingTextHasDecimalSeparator != nil,replacementTextHasDecimalSeparator != nil {
              return false
        } else {
            return true
        }
    }

    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
//        if let text = textField.text,!text.isEmpty{
//            celsiusLable.text = textField.text
//        }
//        else{
//            celsiusLable.text = "???"
//        }
//
        if let text = textField.text,let value = Double(text){
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        }
        else{
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender:UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
}

