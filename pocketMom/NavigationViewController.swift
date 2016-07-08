//
//  NavigationViewController.swift
//  pocketMom
//
//  Created by Sung Kim on 7/7/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarFont = UIFont(name: "ChalkboardSE-Bold", size: 26) ?? UIFont.systemFontOfSize(26)
        self.navigationBar.barStyle = UIBarStyle.Black
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: navBarFont, NSForegroundColorAttributeName:UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
