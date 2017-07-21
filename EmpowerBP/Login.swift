
import UIKit
import Parse


class LoginScreen: UIViewController,
UITextFieldDelegate
{

    /* Views */


    
    

override func viewWillAppear(_ animated: Bool) {
    if PFUser.current() != nil {
        _ = navigationController?.popViewController(animated: true)
    }
}
override func viewDidLoad() {
        super.viewDidLoad()

}

    
// MARK: - LOGIN BUTTON
@IBAction func loginButt(_ sender: AnyObject) {
    passwordText.resignFirstResponder()
    showHUD()

    PFUser.logInWithUsername(inBackground: usernameText.text!, password:passwordTxt.text!) { (user, error) -> Void in
        if error == nil {
            _ = self.navigationController?.popViewController(animated: true)
            self.hideHUD()
            
        // Login failed. Try again or SignUp
        } else {
            self.simpleAlert("\(error!.localizedDescription)")
            self.hideHUD()
    }}
}

    
    
    
    
    
    
// MARK: - FACEBOOK SIGNUP BUTTON
@IBAction func facebookButt(_ sender: Any) {
    // Set permissions required from the Facebook user account
    let permissions = ["public_profile", "email"];
    showHUD()
        
    // Login PFUser using Facebook
    PFFacebookUtils.logInInBackground(withReadPermissions: permissions) { (user, error) in
        if user == nil {
            self.simpleAlert("Facebook login cancelled")
            self.hideHUD()
                
        } else if (user!.isNew) {
            print("NEW USER signed up and logged in through Facebook!");
            self.getFBUserData()
            
        } else {
            print("User logged in through Facebook!");
                
            _ = self.navigationController?.popViewController(animated: true)
            self.hideHUD()
    }}
}
    
    
func getFBUserData() {
    let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, picture.type(large)"])
    let connection = FBSDKGraphRequestConnection()
    connection.add(graphRequest) { (connection, result, error) in
        if error == nil {
            let userData:[String:AnyObject] = result as! [String : AnyObject]
                
            // Get data
            let facebookID = userData["id"] as! String
            let name = userData["name"] as! String
            let email = userData["email"] as! String
                
            // Get avatar
            let currUser = PFUser.current()!
                
            let pictureURL = URL(string: "https://graph.facebook.com/\(facebookID)/picture?type=large")
            let urlRequest = URLRequest(url: pictureURL!)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if error == nil && data != nil {
                    let image = UIImage(data: data!)
                    let imageData = UIImageJPEGRepresentation(image!, 0.8)
                    let imageFile = PFFile(name:"avatar.jpg", data:imageData!)
                    currUser[USER_AVATAR] = imageFile
                    currUser.saveInBackground(block: { (succ, error) in
                        print("...AVATAR SAVED!")
                        self.hideHUD()
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                } else {
                    self.simpleAlert("\(error!.localizedDescription)")
                    self.hideHUD()
            }})
            dataTask.resume()
                
                
            // Update user data
            let nameArr = name.components(separatedBy: " ")
            var username = String()
            for word in nameArr {
                username.append(word.lowercased())
            }
            currUser.username = username
            currUser.email = email
            currUser[USER_FULLNAME] = name
            currUser.saveInBackground(block: { (succ, error) in
                if error == nil {
                    print("USER'S DATA UPDATED...")
            }})
            
            
        } else {
            self.simpleAlert("\(error!.localizedDescription)")
            self.hideHUD()
    }}
    connection.start()
}
    
    

    
    
    
    
    
// MARK: - SIGNUP BUTTON
@IBAction func signupButt(_ sender: AnyObject) {
    let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "Signup") as! Signup
    navigationController?.pushViewController(signupVC, animated: true)
}
  
    
    
    
    
// MARK: - TEXTFIELD DELEGATES
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == usernameTxt { passwordTxt.becomeFirstResponder() }
    if textField == passwordTxt  { passwordTxt.resignFirstResponder() }
    
return true
}
    
    

// MARK: - TAP THE VIEW TO DISMISS KEYBOARD
@IBAction func tapToDismissKeyboard(_ sender: UITapGestureRecognizer) {
    usernameTxt.resignFirstResponder()
    passwordTxt.resignFirstResponder()
}
    
    
    
// MARK: - FORGOT PASSWORD BUTTON
@IBAction func forgotPasswButt(_ sender: AnyObject) {
    let alert = UIAlertController(title: APP_NAME,
        message: "Type your email address you used to register.",
        preferredStyle: .alert)
    
    let ok = UIAlertAction(title: "Reset Password", style: .default, handler: { (action) -> Void in
        // DO AN ACTION
        let textField = alert.textFields!.first!
        let txtStr = textField.text!
        
        PFUser.requestPasswordResetForEmail(inBackground: txtStr, block: { (succ, error) in
            self.simpleAlert("You will receive an email shortly with a link to reset your password")
        })
    })
    
    // Cancel button
    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
    
    // Add textField
    alert.addTextField(configurationHandler: { (textField: UITextField) in
        textField.keyboardAppearance = .dark
        textField.keyboardType = .emailAddress
    })
    
    alert.addAction(ok)
    alert.addAction(cancel)
    present(alert, animated: true, completion: nil)
}



// MARK: - NOTIFICATION ALERT FOR PASSWORD RESET
func showNotifAlert() {
    simpleAlert("You will receive an email shortly with a link to reset your password")
}
    
    
    
    
    
    
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}
}
