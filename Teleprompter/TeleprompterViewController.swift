//
//  TeleprompterViewController.swift
//  Teleprompter
//
//  Created by Carmel Braga on 2/28/20.
//  Copyright © 2020 Carmel Braga. All rights reserved.
//

import UIKit

class TeleprompterViewController: UIViewController {

    @IBOutlet weak var teleprompterTextView: UITextView!
    
    var scrollTimer: Timer?
    
    var currentScroll: CGFloat = 0.0
    var previousScroll: CGFloat = 0.0
    
    var orientations = [Orientation(x: 1, y: 1), Orientation(x: 1, y: -1)]
    var index = 0
    
    var interval = 0.025
    
    func defaultScroll(){
        self.previousScroll = teleprompterTextView.contentSize.height
        self.currentScroll = -(teleprompterTextView.bounds.height/2)
        self.teleprompterTextView.setContentOffset(CGPoint(x: 0, y: self.currentScroll), animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultScroll()
    }
    
    @IBAction func start(_ sender: Any) {
            
        scrollTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: {
            (timer) in
            self.currentScroll += 0.5
            if (self.currentScroll > self.previousScroll) {
                self.scrollTimer?.invalidate()
                return
            }
            
            self.teleprompterTextView.setContentOffset(CGPoint(x: 0, y: self.currentScroll), animated: false)
        
    })
        
}
    
    @IBAction func pause(_ sender: Any) {
        scrollTimer?.invalidate()
    }
    
    @IBAction func stop(_ sender: Any) {
        interval = 0.025
        defaultScroll()
        scrollTimer?.invalidate()
    }
    
    @IBAction func mirror(_ sender: Any) {
        index += 1
        if (index >= orientations.count) {
            index = 0
               }
               
        let orientation = orientations[index]
        teleprompterTextView.transform = CGAffineTransform(scaleX: orientation.x, y: orientation.y)
    }
    
    
    @IBAction func speedUp(_ sender: Any) {
        interval -= 0.005
    }
    
    
    @IBAction func slowDown(_ sender: Any) {
        interval += 0.005
    }
}
