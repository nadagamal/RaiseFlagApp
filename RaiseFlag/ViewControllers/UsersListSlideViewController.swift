//
//  UsersListSlideViewController.swift
//  RaiseFlag
//
//  Created by Nada Gamal Mohamed on 8/1/18.
//  Copyright © 2018 Nada. All rights reserved.
//

import UIKit
import SVProgressHUD
class UsersListSlideViewController: UIViewController,ISHPullUpStateDelegate,ISHPullUpSizingDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var handleView: ISHPullUpHandleView!
    @IBOutlet private weak var rootView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var buttonLock: UIButton?
    private var firstAppearanceCompleted = false
    weak var pullUpController: ISHPullUpViewController!
    var users = [User]()

    private var halfWayPoint = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        topView.addGestureRecognizer(tapGesture)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        readUsersJSON()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstAppearanceCompleted = true;
    }

    @objc private dynamic func handleTapGesture(gesture: UITapGestureRecognizer) {
        if pullUpController.isLocked {
            return
        }
        
        pullUpController.toggleState(animated: true)
    }

    @IBAction private func buttonTappedLock(_ sender: AnyObject) {
        pullUpController.isLocked  = !pullUpController.isLocked
        buttonLock?.setTitle(pullUpController.isLocked ? "Unlock" : "Lock", for: .normal)
    }
    
    // MARK: ISHPullUpSizingDelegate
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, maximumHeightForBottomViewController bottomVC: UIViewController, maximumAvailableHeight: CGFloat) -> CGFloat {
        let totalHeight = rootView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        halfWayPoint = totalHeight / 2.0
        return totalHeight
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, minimumHeightForBottomViewController bottomVC: UIViewController) -> CGFloat {
        return topView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height;
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, targetHeightForBottomViewController bottomVC: UIViewController, fromCurrentHeight height: CGFloat) -> CGFloat {
        // if around 30pt of the half way point -> snap to it
        if abs(height - halfWayPoint) < 30 {
            return halfWayPoint
        }
        // default behaviour
        return height
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forBottomViewController bottomVC: UIViewController) {
        scrollView.contentInset = edgeInsets;
    }
    
    // MARK: ISHPullUpStateDelegate
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, didChangeTo state: ISHPullUpState) {
        handleView.setState(ISHPullUpHandleView.handleState(for: state), animated: firstAppearanceCompleted)
        
        // Hide the scrollview in the collapsed state to avoid collision
        // with the soft home button on iPhone X
        UIView.animate(withDuration: 0.25) { [weak self] in
           self?.scrollView.alpha = (state == .collapsed) ? 0 : 1;
        }
    }
    @objc func readUsersJSON(){
        SVProgressHUD.show()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //self.mapView.clear()
        ServiceManager().getUsers(status: appDelegate.isFirstAppOpen) { (users, error) in
            if  error == nil {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.users = users!
                    self.tableView.reloadData()
                }
            }
            else{
                print("error"+(error?.localizedDescription)!)
            }
        }
        
        
    }

}
extension UsersListSlideViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserCell = tableView .dequeueReusableCell(withIdentifier: "Cell") as! UserCell
        let user = users[indexPath.row]
        cell.userNameLbl.text = user.fullName
        cell.userStatusBtn.tag = indexPath.row
        cell.userStatusBtn .addTarget(self, action: #selector(showUserPopup), for: .touchUpInside)
        if user.outOfRange == true{
            cell.userStatusBtn .setTitle("OUT OF RANGE", for: .normal)
            cell.userStatusBtn .backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.1273266375, alpha: 1)
            cell.userStatusBtn.isHidden = false
            cell.settingsBtn.isHidden = true
            cell.userImage.image = #imageLiteral(resourceName: "rPlaceholder")

        }
        else{
            cell.userStatusBtn .setTitle("Active", for: .normal)
            cell.userStatusBtn .backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            cell.userStatusBtn.isHidden = true
            cell.settingsBtn.isHidden = false
            cell.userImage.image = #imageLiteral(resourceName: "greenPlaceHolder")

        }
        cell.userCountryLbl.text = user.mobile
        
        return cell
    }
    @objc func showUserPopup(sender:UIButton){
        let user = users[sender.tag]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "UserPopUpViewController") as! UserPopUpViewController
        homeVC.user = user
        let alert = UIAlertController(style: .alert, title: "")
        let vc = homeVC
        vc.preferredContentSize.height = 280
        alert.setValue(vc, forKey: "contentViewController")
        alert.show()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
