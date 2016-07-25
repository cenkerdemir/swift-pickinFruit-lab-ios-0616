//
//  ViewController.swift
//  PickinFruit
//
//  Created by Flatiron School on 7/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var fruitPicker: UIPickerView!
    
    var fruitsArray = ["🍎", "🍊", "🍌", "🍐", "🍇", "🍉", "🍓", "🍒", "🍍"]
    let numberOfRows = 9999
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fruitPicker.delegate = self
        self.fruitPicker.dataSource = self
        
        self.fruitPicker.accessibilityLabel = Constants.FRUIT_PICKER
        self.spinButton.accessibilityLabel = Constants.SPIN_BUTTON
    }
    
    @IBAction func spinButtonTapped(sender: UIButton) {
        var selections: [String] = []
        for i in 0..<3 {
            let rowToShow = Int(arc4random_uniform(UInt32(numberOfRows)))
            fruitPicker.selectRow(rowToShow, inComponent: i, animated: true)
            if let symbol = self.pickerView(self.fruitPicker, titleForRow: rowToShow, forComponent: i) {
                selections.append(symbol)
            }
        }
        
        if self.isThereAWinner(selections) {
            self.resultLabel.text = "WINNER!"
            self.animateLabel(self.resultLabel, repeatCount: 16.0)
        }
        else {
            self.resultLabel.text = "TRY AGAIN"
            self.animateLabel(self.resultLabel, repeatCount: 2.0)
        }
    }
    
    func animateLabel(label: UILabel, repeatCount: Float) {
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: [.Repeat/*, .Autoreverse*/], animations: {
            UIView.setAnimationRepeatCount(repeatCount)
            label.alpha = 1.0
            label.alpha = 0.0
            }, completion: nil)
    }
    
    func pickerView(pickerView: UIPickerView,
                      numberOfRowsInComponent component: Int) -> Int {
        return self.numberOfRows
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fruitsArray[row % self.fruitsArray.count]
    }
    
    func isThereAWinner(selections:[String]) -> Bool{
        if selections[0] == selections[1] && selections[0] == selections[2] {
            return true
        }
        else {
            return false
        }
    }
    
}

// MARK: Set Up
extension ViewController {
    
    override func viewDidLayoutSubviews() {
        if self.spinButton.layer.cornerRadius == 0.0 {
            configureButton()
        }
    }
    
    func configureButton()
    {
        self.spinButton.layer.cornerRadius = 0.5 * self.spinButton.bounds.size.width
        self.spinButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.spinButton.layer.borderWidth = 4.0
        self.spinButton.clipsToBounds = true
    }
    
}



