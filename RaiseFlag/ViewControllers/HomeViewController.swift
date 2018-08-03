//
//  HomeViewController.swift
//  RaiseFlag
//
//  Created by Nada Gamal Mohamed on 8/1/18.
//  Copyright © 2018 Nada. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import SwiftMessages
let kPurpleButtonBackgroundColor: UIColor =  UIColor(red: 146.0/255.0, green: 166.0/255.0, blue: 218.0/255.0, alpha: 0.90)
let kGreenButtonBackgroundColor: UIColor = UIColor(red: 142.0/255.0, green: 224.0/255.0, blue: 102.0/255.0, alpha: 0.90)
let kRedButtonBackgroundColor: UIColor =  UIColor(red: 244.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 0.90)
let kBlueButtonBackgroundColor: UIColor = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 0.90)
let kDisabledBlueButtonBackgroundColor: UIColor = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 0.10)
let kDisabledRedButtonBackgroundColor: UIColor =  UIColor(red: 244.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 0.10)
let kWhiteBackgroundColor: UIColor = UIColor(red: 254.0/255.0, green: 254.0/255.0, blue: 254.0/255.0, alpha: 0.90)


class HomeViewController: ISHPullUpViewController {

    var timer = Timer()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSlideView()
        self.timer = Timer.scheduledTimer(timeInterval: 3.0,
                                          target: self,
                                          selector: #selector(presentAdsView),
                                          userInfo: nil,
                                          repeats: false)
        
    }
    @objc func presentAdsView(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let bottomVC = storyBoard.instantiateViewController(withIdentifier: "AdsViewController") as! AdsViewController
        bottomVC.modalPresentationStyle = .overFullScreen
        bottomVC.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        navigationController?.present(bottomVC, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: (.now()+3), execute: {
                self.dismiss(animated: true, completion: {
                    
                })
            })
        })
        
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        addSlideView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo"))
       // addBarButtons()
        
    }
    func addBarButtons(){
        let rightBarBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 12))
        rightBarBtn .setBackgroundImage(#imageLiteral(resourceName: "track"), for: .normal)
        rightBarBtn.imageView?.contentMode = .scaleAspectFit
        //navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarBtn)
        
        let leftBarBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 12))
        leftBarBtn .setBackgroundImage(#imageLiteral(resourceName: "set"), for: .normal)
        leftBarBtn.imageView?.contentMode = .scaleAspectFit

       // navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarBtn)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addSlideView(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let bottomVC = storyBoard.instantiateViewController(withIdentifier: "UsersListSlideViewController") as! UsersListSlideViewController
        let contentVC = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        bottomViewController = bottomVC
        contentViewController = contentVC
        bottomVC.pullUpController = self
        contentDelegate = contentVC
        sizingDelegate = bottomVC
        stateDelegate = bottomVC
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
