import UIKit
import Parse


class ShowSingleInt: UIViewController,
UIAlertViewDelegate,
UIScrollViewDelegate,
UITextFieldDelegate

{

/* Views */
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var infoStack: UIStackView!
    @IBOutlet weak var intName: UILabel!
    @IBOutlet weak var intText: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var editStack: UIStackView!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var favButton: UIButton!

    
    
/* Variables */
    var singleIntObj = PFObject(className: INT_CLASS_NAME)
    var postTitle = ""
    

    
    
    
    

    
override func viewDidLoad() {
        super.viewDidLoad()
    

    showIntDetails()

    // Reset variables for Reply
    postTitle = ""
    
}

    
    
    
    
// MARK: - SHOW DETAILS
func showIntDetails() {
    
    // Get Title
    intName.text = "\(singleIntObj[INT_RESOURCE_TITLE]!)"
    self.title = "\(singleIntObj[INT_RESOURCE_TITLE]!)"
    

    // Get Description
    intText.text = "\(singleIntObj[INT_TEXT]!)"
}
    
    
//
//// OPEN SELLER'S WEBSITE (IF IT EXISTS)
//@IBAction func websiteButt(_ sender: AnyObject) {
//    let butt = sender as! UIButton
//    let webStr = "\(butt.titleLabel!.text!)"
//    if webStr != "N/D" {
//        let webURL = URL(string: webStr)
//        UIApplication.shared.openURL(webURL!)
//    }
//}
// 
//    
//    
//    
//// MARK: - ADMOB INTERSTITIAL DELEGATES
//func showInterstitial() {
//    // Show AdMob interstitial
//    if adMobInterstitial.isReady {
//        adMobInterstitial.present(fromRootViewController: self)
//        print("present Interstitial")
//    }
//}
//
//    
//    
////MARK: - ADD A PIN ON THE MAP
//func addPinOnMap(_ address: String) {
//    mapView.delegate = self
//    
//    if mapView.annotations.count != 0 {
//            annotation = mapView.annotations[0] 
//            mapView.removeAnnotation(annotation)
//    }
//        // Make a search on the Map
//        localSearchRequest = MKLocalSearchRequest()
//        localSearchRequest.naturalLanguageQuery = address
//        localSearch = MKLocalSearch(request: localSearchRequest)
//            
//        localSearch.start { (localSearchResponse, error) -> Void in
//            // Place not found or GPS not available
//            if localSearchResponse == nil  {
//                let alert = UIAlertView(title: APP_NAME,
//                message: "Place not found, or GPS not available",
//                delegate: nil,
//                cancelButtonTitle: "Try again" )
//                alert.show()
//            }
//                
//            // Add PointAnnonation text and a Pin to the Map
//            self.pointAnnotation = MKPointAnnotation()
//            self.pointAnnotation.title = self.adTitleLabel.text
//            self.pointAnnotation.subtitle = self.addressLabel.text
//            self.pointAnnotation.coordinate = CLLocationCoordinate2D( latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:localSearchResponse!.boundingRegion.center.longitude)
//                
//            self.pinView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
//            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
//                self.mapView.addAnnotation(self.pinView.annotation!)
//                
//            // Zoom the Map to the location
//            self.region = MKCoordinateRegionMakeWithDistance(self.pointAnnotation.coordinate, 1000, 1000);
//            self.mapView.setRegion(self.region, animated: true)
//            self.mapView.regionThatFits(self.region)
//            self.mapView.reloadInputViews()
//        }
//}
//
// 
//    
//// MARK: - ADD RIGHT CALLOUT TO OPEN IN IOS MAPS APP
//func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        
//        // Handle custom annotations.
//        if annotation.isKind(of: MKPointAnnotation.self) {
//            
//            // Try to dequeue an existing pin view first.
//            let reuseID = "CustomPinAnnotationView"
//            var annotView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
//            
//            if annotView == nil {
//                annotView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
//                annotView!.canShowCallout = true
//                
//                // Custom Pin image
//                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
//                imageView.image =  UIImage(named: "locationButt")
//                imageView.center = annotView!.center
//                imageView.contentMode = UIViewContentMode.scaleAspectFill
//                annotView!.addSubview(imageView)
//                
//                // Add a RIGHT CALLOUT Accessory
//                let rightButton = UIButton(type: UIButtonType.custom)
//                rightButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
//                rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
//                rightButton.clipsToBounds = true
//                rightButton.setImage(UIImage(named: "openInMaps"), for: UIControlState())
//                annotView!.rightCalloutAccessoryView = rightButton
//            }
//    return annotView
//    }
//        
//return nil
//}
//    
//    
//    
//// MARK: - OPEN THE NATIVE iOS MAPS APP
//func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//    annotation = view.annotation
//    let coordinate = annotation.coordinate
//    let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
//    let mapitem = MKMapItem(placemark: placemark)
//    mapitem.name = annotation.title!
//    mapitem.openInMaps(launchOptions: nil)
//}
//    
//
//    
//    
//    
//// MARK: - SCROLLVIEW DELEGATE
//func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    // switch pageControl to current page
//    let pageWidth = imagesScrollView.frame.size.width
//    let page = Int(floor((imagesScrollView.contentOffset.x * 2 + pageWidth) / (pageWidth * 2)))
//    pageControl.currentPage = page
//}
//    
//    
//// MARK: - TEXTFIELD DELEGATE
//func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//    if textField == nameTxt { emailTxt.becomeFirstResponder() }
//    if textField == emailTxt { phoneTxt.becomeFirstResponder() }
//    if textField == phoneTxt { phoneTxt.resignFirstResponder() }
//        
//return true
//}
//    
//    
//    
//    
//    
//// MARK: - SEND REPLY BUTTON
//@IBAction func sendReplyButt(_ sender: AnyObject) {
//    let userPointer = singleAdObj[CLASSIF_USER] as! PFUser
//    userPointer.fetchIfNeededInBackground { (user, error) in
//        if error == nil {
//
//            self.receiverEmail = userPointer.email!
//            self.postTitle = self.adTitleLabel.text!
//            print("\(self.receiverEmail)")
//    
//            if self.messageTxt.text != "" && self.emailTxt.text != ""  && self.nameTxt.text != "" {
//                
//                let strURL = "\(PATH_TO_PHP_FILE)sendReply.php?name=\(self.nameTxt.text!)&fromEmail=\(self.emailTxt.text!)&tel=\(self.phoneTxt.text!)&messageBody=\(self.messageTxt.text!)&receiverEmail=\(self.receiverEmail)&postTitle=\(self.postTitle)"
//                let reqURL = URL(string: strURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)! )!
//                let request = NSMutableURLRequest()
//                request.url = reqURL
//                request.httpMethod = "GET"
//                let connection = NSURLConnection(request: request as URLRequest, delegate: self, startImmediately: true)
//                print("REQUEST URL: \(reqURL) - \(connection!.description)")
//        
//                self.simpleAlert("Thanks, You're reply has been sent!")
//            
//    
//                // SOME REQUIRED FIELD IS EMPTY...
//                } else { self.simpleAlert("Please fill all the required fields.") }
//            
//    
//        } else { self.simpleAlert("\(error!.localizedDescription)")
//    }}
//}
//    
// 
//    
//    
//    
//    
//// MARK: - PHONE CALL BUTTON
//@IBAction func phoneCallButt(_ sender: AnyObject) {
//    let userPointer = singleAdObj[CLASSIF_USER] as! PFUser
//    userPointer.fetchIfNeededInBackground { (user, error) in
//        if error == nil {
//            let aURL = URL(string: "telprompt://\(userPointer[USER_PHONE]!)")!
//            if UIApplication.shared.canOpenURL(aURL) {
//                UIApplication.shared.openURL(aURL)
//            } else {
//                self.simpleAlert("This device can't make phone calls")
//            }
//     
//        } else { self.simpleAlert("\(error!.localizedDescription)")
//    }}
//}
//    
//    
//    
// 
//// MARK: - REPORT AD BUTTON
//func reportButton(_ sender:UIButton) {
//    let alert = UIAlertController(title: APP_NAME,
//        message: "tell us briefly the reason why you're rporting this ad:",
//        preferredStyle: .alert)
//    
//    
//    let ok = UIAlertAction(title: "Report ad", style: .default, handler: { (action) -> Void in
//        // TextField
//        let textField = alert.textFields!.first!
//        let txtStr = textField.text!
//        
//        self.singleAdObj[CLASSIF_IS_REPORTED] = true
//        self.singleAdObj[CLASSIF_REPORT_MESSAGE] = txtStr
//        self.singleAdObj.saveInBackground(block: { (succ, error) in
//            if error == nil {
//                self.simpleAlert("Thanks for reporting this ad.\nWe'll check it out within 24h.")
//                _ = self.navigationController?.popToRootViewController(animated: true)
//            }})
//    })
//    
//    // Cancel button
//    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
//    
//    // Add textField
//    alert.addTextField { (textField: UITextField) in
//        textField.keyboardAppearance = .dark
//        textField.keyboardType = .default
//    }
//    
//    alert.addAction(ok)
//    alert.addAction(cancel)
//    present(alert, animated: true, completion: nil)
//}
//
//    
// 
//    
//    
//    
//    
//// MARK: - SHOW IMAGE PREVIEW BUTTONS
//@IBAction func showImagePreviewButt(_ sender: AnyObject) {
//    let butt = sender as! UIButton
//        
//    var imageFile:PFFile?
//        
//    switch butt.tag {
//        case 0: imageFile = singleAdObj[CLASSIF_IMAGE1] as? PFFile
//        case 1: imageFile = singleAdObj[CLASSIF_IMAGE2] as? PFFile
//        case 2: imageFile = singleAdObj[CLASSIF_IMAGE3] as? PFFile
//    default:break }
//        
//    // Get image
//    imageFile?.getDataInBackground(block: { (imageData, error) -> Void in
//        if error == nil {
//            if let imageData = imageData {
//                self.imgPrev.image = UIImage(data:imageData)
//                self.showImagePrevView()
//    }}})
//}
//    
//    
//// MARK: - TAP ON IMAGE TO CLOSE PREVIEW
//@IBAction func tapToClosePreview(_ sender: UITapGestureRecognizer) {
//    hideImagePrevView()
//}
//    
//    
//// MARK: - SHOW/HIDE PREVIEW IMAGE VIEW
//func showImagePrevView() {
//    UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
//        self.imagePreviewView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//        self.instructionsLabel.isHidden = false
//        self.imgPrev.frame = self.imagePreviewView.frame
//    }, completion: { (finished: Bool) in  })
//}
//func hideImagePrevView() {
//    imgPrev.image = nil
//    UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
//        self.imagePreviewView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
//        self.instructionsLabel.isHidden = true
//        self.imgPrev.frame = self.imagePreviewView.frame
//        }, completion: { (finished: Bool) in  })
//}
//
//    
//// MARK: - SCROLLVIW DELEGATE FOR ZOOMING IMAGE
//func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//    return imgPrev
//}
    
    
    
    
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
