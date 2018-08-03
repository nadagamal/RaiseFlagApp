//
//  SplashViewController.swift
//  RaiseFlag
//
//  Created by Nada Gamal Mohamed on 8/2/18.
//  Copyright © 2018 Nada. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = true
        DispatchQueue.main.asyncAfter(deadline: (.now()+1.5), execute: {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.show(homeVC, sender: nil)
//            var appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
//            appDelegate.window?.rootViewController = UINavigationController(rootViewController: homeVC)
//            appDelegate.window?.makeKeyAndVisible()
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false

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
