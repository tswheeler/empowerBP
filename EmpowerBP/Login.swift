
import UIKit
import Parse
import Foundation
import Alamofire


class Login: UIViewController,
UITextFieldDelegate
{

    /* Views */
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    
    

override func viewWillAppear(_ animated: Bool) {
    if PFUser.current() != nil {
        _ = navigationController?.popViewController(animated: true)
    }
}
override func viewDidLoad() {
        super.viewDidLoad()

}

    
// MARK: - LOGIN BUTTON
@IBAction func loginButton(_ sender: AnyObject) {
    passwordText.resignFirstResponder()
    showHUD()
    getUserToken()
    
//Added
    
    ///THIS NEEDS TO BE IT'S OWN FUNCITON
    
//    var headers: HTTPHeaders = [
//        "Accept": "application/json"
//    ]
//    
//    let parameters = [
//        "username" : self.usernameText.text!,
//        "password" : self.passwordText.text!
//    ]
//    
//    
 //   if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
 //       headers[authorizationHeader.key] = authorizationHeader.value
//    }
//    
//    let url = "https://aabusharekh-4.cs.dal.ca:8443/api/v1/register"
//    var statusCode: Int = 0
//    Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON).responseJSON{ response in
//        
//        switch response.result {
//        case .success:
//        print(response)
//            return
//        case .failure(let error):
//            print(error)
//        }}
//    
//End New
    
    

//    PFUser.logInWithUsername(inBackground: usernameText.text!, password:passwordText.text!) { (user, error) -> Void in
//        if error == nil {
//            _ = self.navigationController?.popViewController(animated: true)
//            self.hideHUD()
//            self.performSegue(withIdentifier: "toMainScene", sender: self)
//            
//        // Login failed. Try again or SignUp
//        } else {
//            self.simpleAlert("\(error!.localizedDescription)")
            self.hideHUD()
  //  }}
}

// CONFIRM USER AND GET TOKEN
    
    func getUserToken() {
        
        
        
        let headers = [
            "Authorization": "Bearer $TK"
        ]
        let parameters: Parameters = [
            "username": usernameText.text!,
            "password": passwordText.text!,
            
        ]
        Alamofire.request("https://aabusharekh-4.cs.dal.ca:8443/api/v1/authenticate", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    print(response)
                    self.hideHUD()
                    return
                case .failure(let error):
                    print(response)
                    self.simpleAlert("\(error.localizedDescription)")
                    self.hideHUD()
                    return
                }}
        
    }

    
    
// MARK: - TEXTFIELD DELEGATES
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == usernameText { passwordText.becomeFirstResponder() }
    if textField == passwordText  { passwordText.resignFirstResponder() }
    
return true
}
    
    

// MARK: - TAP THE VIEW TO DISMISS KEYBOARD
@IBAction func tapToDismissKeyboard(_ sender: UITapGestureRecognizer) {
    usernameText.resignFirstResponder()
    passwordText.resignFirstResponder()
}
    
    
    
// MARK: - FORGOT PASSWORD BUTTON
@IBAction func forgotPasswordButton(_ sender: AnyObject) {
    let alert = UIAlertController(title: "EmpowerBP",
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
