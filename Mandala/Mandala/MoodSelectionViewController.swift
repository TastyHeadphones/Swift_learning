//
//  ViewController.swift
//  Mandala
//
//  Created by Magic Keegan on 10/31/21.
//

import UIKit

class MoodSelectionViewController: UIViewController {
    
    
//    @IBOutlet var stackView: UIStackView!
    @IBOutlet var moodSelector: ImageSelector!
    @IBOutlet var addMoodButton: UIButton!
    
    @IBAction func addMoodTapped(_sender: Any){
        guard let currentMood = currentMood else{
            return
        }
        
        let newMoodEntry = MoodEntry(mood: currentMood, timestamp: Date())
        moodConfigurable.add(newMoodEntry)
        
    }
    var moods: [Mood] = []{
        didSet{
            currentMood = moods.first
//            moodButtons = moods.map{ mood in
//                let moodButton = UIButton()
//                moodButton.setImage(mood.image,for:.normal)
//                moodButton.imageView?.contentMode = .scaleAspectFit
//                moodButton.adjustsImageWhenHighlighted = false
//                moodButton.addTarget(self, action: #selector(moodSelectionChanged(_:)), for: .touchUpInside)
//                return moodButton
            moodSelector.images = moods.map{$0.image}
//            }
        }
    }
//    var moodButtons: [UIButton] = []{
//        didSet{
//            oldValue.forEach{$0.removeFromSuperview()}
//            moodButtons.forEach{ stackView.addArrangedSubview(($0))}
//        }
//    }
    
    var currentMood: Mood?{
        didSet{
            guard let currentMood = currentMood else {
                addMoodButton?.setTitle(nil, for: .normal)
                addMoodButton?.backgroundColor = nil
                return
            }
            moodSelector.changehighlightViewBackgroundColor(currentMood.color)
            addMoodButton?.setTitle("I'm \(currentMood.name)", for: .normal)
//            addMoodButton?.backgroundColor = currentMood.color
            let selectionAnimator = UIViewPropertyAnimator(duration: 0.3,
                                                                   dampingRatio: 0.7) {
                        self.addMoodButton?.backgroundColor = currentMood.color
                    }
                    selectionAnimator.startAnimation()
        }
    }
    
    @IBAction private func moodSelectionChanged(_ sender: ImageSelector) {
        let selectedIndex = sender.selectedIndex
        currentMood = moods[selectedIndex]
//        guard let selectedIndex = moodButtons.firstIndex(of: sender) else {
//            preconditionFailure(
//                    "Unable to find the tapped button in the buttons array.")
//    }
//        currentMood = moods[selectedIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
        
    }
    
    var moodConfigurable: MoodsConfigurable!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "embedContainerViewController":
            guard let moodConfigurable = segue.destination as? MoodsConfigurable else {
                preconditionFailure("View controller expected to conform to MoodsConfigurable")
            }
            self.moodConfigurable = moodConfigurable
            segue.destination.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
            
        default:preconditionFailure("Unexpected segue identifier")
        }
        
    }

}

