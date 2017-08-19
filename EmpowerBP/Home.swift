import UIKit
import Parse

// MARK: - HOME CUSTOM CELL
class HomeCell: UITableViewCell {
    /* Views */
    @IBOutlet weak var intTitleLabel: UILabel!
    @IBOutlet weak var intTextLabel: UILabel!
   
}


// MARK: - HOME CONTROLLER
class Home: UITableViewController {


    /* Variables */
    var interventionArray = [PFObject]()
    var postObj = PFObject(className: INT_CLASS_NAME)
    
    
override func viewDidLoad() {
    showHUD()
    
    let query = PFQuery(className: INT_CLASS_NAME)
    query.whereKey(INT_GOAL, equalTo:"ReduceSaltIntake")
    query.findObjectsInBackground { (objects, error)-> Void in
        if error == nil {
            self.interventionArray = objects!
            self.hideHUD()
            self.tableView.reloadData()
            
        } else {
            self.simpleAlert("\(error!.localizedDescription)")
            self.hideHUD()
        }}
        super.viewDidLoad()

}

// MARK: - TABLEVIEW DELEGATES
override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return interventionArray.count
}
    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
    var intClass = PFObject(className: INT_CLASS_NAME)
    intClass = interventionArray[indexPath.row]
        
    cell.intTitleLabel.text = "\(intClass[INT_RESOURCE_TITLE]!)"
    cell.intTextLabel.text = "\(intClass[INT_TEXT]!)"
    //cell.addToFavOutlet.tag = indexPath.row
        
    return cell
}
    
// MARK: - SELECTED AN INTERVENTION -> SHOW IT
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var intClass = PFObject(className: INT_CLASS_NAME)
        intClass = interventionArray[indexPath.row]
        
        let showIntVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowSingleInt") as! ShowSingleInt
        // Pass the Ad Object to the Controller
        showIntVC.singleIntObj = intClass
        self.navigationController?.pushViewController(showIntVC, animated: true)
    }
    
// MARK: SWIPE CELLS
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
            print("more button tapped")
        }
        more.backgroundColor = .lightGray
        
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
            print("favorite button tapped")
        }
        favorite.backgroundColor = .orange
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
            print("share button tapped")
        }
        share.backgroundColor = .blue
        
        return [share, favorite, more]
    }

// MARK: - SELECTED AN AD -> SHOW IT
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    var classifClass = PFObject(className: CLASSIF_CLASS_NAME)
//    classifClass = searchedAdsArray[indexPath.row]
//        
//    let showAdVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowSingleAd") as! ShowSingleAd
//    // Pass the Ad Object to the Controller
//    showAdVC.singleAdObj = classifClass
//    self.navigationController?.pushViewController(showAdVC, animated: true)
//}
    
    
    
    
    
//    // MARK: - ADD AD TO FAVORITES BUTTON
//    @IBAction func addToFavButt(_ sender: AnyObject) {
//        let button = sender as! UIButton
//        
//        // Get this ad
//        var adObj = PFObject(className: CLASSIF_CLASS_NAME)
//        adObj = searchedAdsArray[button.tag]
//        
//        
//        if PFUser.current() != nil {
//            
//            // CHECK IF YOU'VE FAVORITED ALREADY THIS AD
//            let query = PFQuery(className: FAV_CLASS_NAME)
//            query.whereKey(FAV_USER_POINTER, equalTo: PFUser.current()!)
//            query.whereKey(FAV_AD_POINTER, equalTo: adObj)
//            query.findObjectsInBackground { (objects, error)-> Void in
//                if error == nil {
//                    if objects?.count !=  0 {
//                        self.simpleAlert("You've already added this ad to your Favorites!")
//                        
//                        // ADD THIS AD TO YOUR FAVORITES
//                    } else {
//                        let favClass = PFObject(className: FAV_CLASS_NAME)
//                        favClass[FAV_USERNAME] = PFUser.current()?.username!
//                        favClass[FAV_USER_POINTER] = PFUser.current()!
//                        favClass[FAV_AD_POINTER] = adObj
//                        
//                        // Saving block
//                        favClass.saveInBackground { (success, error) -> Void in
//                            if error == nil {
//                                self.simpleAlert("This Ad has been added to your Favorites!")
//                            } else {
//                                self.simpleAlert("\(error!.localizedDescription)")
//                            }}
//                    }
//                    
//                } else {
//                    self.simpleAlert("\(error!.localizedDescription)")
//                }}
//            
//            
//            
//            
//            
//            
//            
//            
//            
//            
//            // YOU MUST BE LOGGED IN TO FAVROITE!
//        } else { simpleAlert("You have to login/signup to favorite ads!") }
//        
//        
//    }
//    
//    
//    
//    
//    
//    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}
}
