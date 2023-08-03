//
//  ViewController.swift
//  IconButton
//
//  Created by wyqpadding@gmail.com on 03/24/2023.
//  Copyright (c) 2023 wyqpadding@gmail.com. All rights reserved.
//

import UIKit
import IconButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let iconButton = IconButton(target: self, action: #selector(tapAction))
        iconButton.setTitle("hello", for: .normal)
        iconButton.setTitleColor(UIColor.red, for: .normal)
        iconButton.setTitleColor(UIColor.green, for: .selected)
        iconButton.setImage(UIImage(named: "icon_person_default"), for: .normal)
        iconButton.setImage(UIImage(named: "news_search"), for: .selected)
        iconButton.backgroundColor = UIColor.gray
        
        view.addSubview(iconButton)
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        iconButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        iconButton.heightAnchor.constraint(equalToConstant: 26).isActive = true
        iconButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(5), execute: {
            iconButton.isSelected = true
        })
        
    }

    @objc func tapAction() {
        print("taped once")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

