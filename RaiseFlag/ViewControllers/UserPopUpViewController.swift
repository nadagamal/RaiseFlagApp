//
//  UserPopUpViewController.swift
//  RaiseFlag
//
//  Created by Nada Gamal Mohamed on 8/3/18.
//  Copyright © 2018 Nada. All rights reserved.
//

import UIKit

class UserPopUpViewController: UITableViewController{

    var user:User!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            guard let number = URL(string: "tel://" + user.mobile) else { return }
            
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        }
        else if indexPath.row == 2{
            guard let number = URL(string: "tel://" + user.mobile) else { return }
            
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        }
        else if indexPath.row == 3{
            self.dismiss(animated: true) {
                
            }
        }
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
