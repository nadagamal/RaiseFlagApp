//
//  AdsViewController.swift
//  RaiseFlag
//
//  Created by Nada Gamal Mohamed on 8/3/18.
//  Copyright © 2018 Nada. All rights reserved.
//

import UIKit

class AdsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func adPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.saudia.com/")!, options: [:], completionHandler: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
