//
//  TrackModeViewController.swift
//  RaiseFlag
//
//  Created by Nada Gamal Mohamed on 8/3/18.
//  Copyright © 2018 Nada. All rights reserved.
//

import UIKit

class TrackModeViewController: UIViewController {

    @IBOutlet weak var customeModeBtn: UIButton!
    @IBOutlet weak var trackmode: UIButton!
    @IBOutlet weak var freemodeBtn: UIButton!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func freeModeBtnAction(_ sender: Any) {
        freemodeBtn.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4666666667, blue: 0.9058823529, alpha: 1)
        trackmode.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        customeModeBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    @IBAction func customMode(_ sender: Any) {
        freemodeBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        trackmode.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        customeModeBtn.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4666666667, blue: 0.9058823529, alpha: 1)
    }
    @IBAction func trackModeAction(_ sender: Any) {
        freemodeBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        trackmode.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4666666667, blue: 0.9058823529, alpha: 1)
        customeModeBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.tableHeaderView = UIView()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
extension TrackModeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UserCell
       // let user = User
        if indexPath.row == 2{
            cell = tableView.dequeueReusableCell(withIdentifier: "ActionsCell") as! UserCell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2{
            return 129
        }
        return 90
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
