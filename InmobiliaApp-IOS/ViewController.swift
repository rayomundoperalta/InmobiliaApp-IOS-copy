//
//  ViewController.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 12/27/16.
//  Copyright © 2016 Industrias Peta. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var go:Bool = true

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var botonLogin: FBSDKLoginButton!
    var loggedIn : Bool = false;
    
    let contentURL = "http://avaluos.peta.mx"
    let contentURLImage = "http://peta.mx/images/favicon/apple-icon-180x180.png"
    let contentTitle = "Está usando InmobiliaApp para lograr un buen trato para su nueva casa"
    let contentDescription = "esta localización le gusta y está a buen precio "
    var imagePicker = UIImagePickerController()
    var mediaSelected = ""
    
    override func viewDidLoad() {
        print("-->  Facebook View did load")
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        print("-->  Facebook login viewWilAppear")
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            print("AccessToken distinto de nil")
            // User is already logged in, do work such as go to next view controller.
            loggedIn = true
            
            // Or Show Logout Button
            botonLogin.setTitle("Log out", forState: UIControlState.Normal)
            botonLogin.center = self.view.center
            botonLogin.readPermissions = ["public_profile", "email", "user_friends"]
            botonLogin.delegate = self
            self.returnUserData()
            ImageView.hidden  = false
        }
        else
        {
            loggedIn = false
            print("AccessToken igual a nil")
            botonLogin.setTitle("Facebook Login", forState: UIControlState.Normal)
            botonLogin.center = self.view.center
            botonLogin.readPermissions = ["public_profile", "email", "user_friends"]
            botonLogin.delegate = self
            ImageView.hidden  = true
        }
        
        print("Termina view will appear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func returnUserData()
    {
        print("Estamos en return User Data")
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture.type(large), verified"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            print("Dentro de la funcion call back")
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                /*
                    En este punto estamos seguros de que el usuario esta logedo y de que tenemos sus datos
                    por lo cual podemos pasar al siguiente controlador
                */
                print("fetched user: \(result)")
                
                if let userName : NSString = result.valueForKey("name") as? NSString {
                    print("User Name is: \(userName)")
                    ValoresGlobales.sharedInstance.userName = userName as String
                }
                if (result.valueForKey("picture") != nil) {
                    let picture : NSString = result.valueForKey("picture")?.valueForKey("data")?.valueForKey("url") as! NSString
                    print("User Picture URL is: \(picture)")
                    // picture contiene realmente el URL de donde hay que descargar la imagen
                    if let url = NSURL(string: picture as String) {
                        if let data = NSData(contentsOfURL: url) {
                            self.ImageView.contentMode = UIViewContentMode.ScaleAspectFit
                            self.ImageView.image = UIImage(data: data)
                        }
                    }
                }
                if let email : NSString = result.valueForKey("email") as? NSString {
                    print("User Email: \(email)")
                    ValoresGlobales.sharedInstance.userEmail = email as String
                }
                if let verified : CFBoolean = (result.valueForKey("verified") as! CFBoolean) {
                    print("Verified: \(verified)")
                }
                if self.go {
                    self.performSegueWithIdentifier("PasemosAlMapaMenu", sender: self)
                }
            }
            print("Termina Call back")
        })
        print("termina return User Data")
    }
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("We are in loginButton <----------------")
        
        if ((error) != nil)
        {
            loggedIn = false
            ImageView.hidden  = true
            botonLogin.center = self.view.center
            botonLogin.setTitle("Facebook Log in", forState: UIControlState.Normal)
            // Process error
            print("\(error)")
        }
        else if result.isCancelled {
            loggedIn = false
            ImageView.hidden  = true
            botonLogin.center = self.view.center
            botonLogin.setTitle("Facebook Log in", forState: UIControlState.Normal)
            // Handle cancellations
            print("Cancelado")
        }
        else {
            print("We are logged in")
            loggedIn = true
            botonLogin.center = self.view.center
            botonLogin.setTitle("Log out", forState: UIControlState.Normal)
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            print("granted \(result.grantedPermissions)")
            print("declained \(result.declinedPermissions)")
            
            if result.grantedPermissions.contains("email")
            {
                // Do work with the email
                print("Tenemos el email")
            }
            self.returnUserData()
            ImageView.hidden  = false
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        loggedIn = false
        botonLogin.setTitle("Facebook Login", forState: UIControlState.Normal)
        ImageView.hidden  = true
    }
}

