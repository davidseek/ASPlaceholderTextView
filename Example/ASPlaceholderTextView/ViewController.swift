//
//  ViewController.swift
//  ASPlaceholderTextView
//
//  Created by Adam Share on 04/09/2016.
//  Copyright (c) 2016 Adam Share. All rights reserved.
//

import UIKit
import ASPlaceholderTextView

class ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: ASPlaceholderTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        
        // Paste in images
        textView.allowImages = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        textView.maximumImageSize = CGSize(width: textView.frame.size.width/2, height: CGFloat.max)
        
//        textView.placeholder = "Some longer text to check out the sizing of the placeholder against how text should appear in this box that is typed..."
//        textView.textContainerInset = UIEdgeInsets(top: 15, left: 30, bottom: 0, right: 30)
//        textView.textAlignment = .Right
//        textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    }
    
    func textViewDidChange(_ textView: UITextView) {
//        print(textView.text)
    }
}

