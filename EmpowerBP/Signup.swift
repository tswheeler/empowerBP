/* =======================

- Classify -

made by FV iMAGINATION ©2015
for CodeCanyon

==========================*/


import UIKit
import Parse


class Signup: UIViewController,
UITextFieldDelegate
{

    /* Views */
    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet var usernameTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var signupOutlet: UIButton!
    @IBOutlet weak var touOutlet: UIButton!
    
    @IBOutlet var bkgViews: [UIView]!
    
   

override func viewDidLoad() {
        super.viewDidLoad()
        
    self.title = "SIGN UP"
    
    // Round views corners
    signupOutlet.layer.cornerRadius = 5
    touOutlet.layer.cornerRadius = 5
    for view in bkgViews { view.layer.cornerRadius = 8 }
    
    
    containerScrollView.contentSize = CGSize(width: containerScrollView.frame.size.width, height: 550)
}
    

// MARK: - TAP TO DISMISS KEYBOARD
@IBAction func tapToDismissKeyboard(_ sender: UITapGestureRecognizer) {
    usernameTxt.resignFirstResponder()
    passwordTxt.resignFirstResponder()
    emailTxt.resignFirstResponder()
}
 
    
    
// MARK: - SIGNUP BUTTON
@IBAction func signupButt(_ sender: AnyObject) {
    if usernameTxt.text == "" || passwordTxt.text == "" || emailTxt.text == "" {
        simpleAlert("You must fill all the fields to Sign Up!")
        
    } else {
        showHUD()
        let userForSignUp = PFUser()
        userForSignUp.username = usernameTxt.text
        userForSignUp.password = passwordTxt.text
        userForSignUp.email = emailTxt.text
    
        userForSignUp.signUpInBackground { (succeeded, error) -> Void in
            if error == nil { // Successful Signup
                _ = self.navigationController?.popToRootViewController(animated: true)
                self.hideHUD()
            
            // error
            } else {
                self.simpleAlert("\(error!.localizedDescription)")
                self.hideHUD()
        }}
    
    }
}
   
    
    
// MARK: - TEXTFIELD DELEGATES
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == usernameTxt {   passwordTxt.becomeFirstResponder()  }
    if textField == passwordTxt {  emailTxt.becomeFirstResponder()  }
    if textField == emailTxt {   emailTxt.resignFirstResponder()   }
        
return true
}


    
// MARK: - TERMS OF USE BUTTON
@IBAction func touButt(_ sender: AnyObject) {
    let touVC = self.storyboard?.instantiateViewController(withIdentifier: "TermsOfUse") as! TermsOfUse
    present(touVC, animated: true, completion: nil)
}
    
    
    

    
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}
}
