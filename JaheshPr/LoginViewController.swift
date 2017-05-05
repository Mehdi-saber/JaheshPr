//
//  LoginViewController.swift
//  ARToolKit5iOS
//
//  Created by mehdi sabermahani on 4/21/17.
//
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class LoginViewController: UIViewController {
    
    var manager: SessionManager?
    
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet var indicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10 // seconds
        configuration.timeoutIntervalForResource = 10
        manager = SessionManager(configuration: configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func resquestToken(_ password:String){
        
        let parameters: Parameters = [ "password": password]
        let requestURL=Constant.appApiAddress+"login.json"
        if MyUtils.isConnectedToInternet(){
            manager!.request(requestURL, method: .post, parameters: parameters, encoding: JSONEncoding(options: [])).responseJSON {
                response in
                
                var failed=true;
                self.indicator.stopAnimating()
                self.submit.isEnabled=self.mySwitch.isOn
                
                switch response.result {
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    if let token = response.object(forKey: "token"){
                        MyUtils.saveToDefaults("token", newValue: token);
                        failed=false
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
                
                if(!failed){
                    self.openTabBar()
                }
                else{
                    let alert = UIAlertController(title: "ارتباط با سرور", message: "خطا در ارتباط با سرور", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "امتحان دوباره", style: .default, handler: {
                        action in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            
        }
        else {
            
            self.indicator.stopAnimating()
            self.submit.isEnabled=self.mySwitch.isOn

            let alert = UIAlertController(title: "اتصال به اینترنت", message: "اتصال خود را به اینترنت چک کنید.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "امتحان دوباره", style: .default, handler: {
                action in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func openTabBar(){
        let tabBar : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "MyTabBar") as UIViewController
        self.present(tabBar, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func switchChanged(_ sender: Any) {
        submit.isEnabled=mySwitch.isOn
    }
    @IBAction func LoginTouched(_ sender: Any) {
        indicator.startAnimating()
        submit.isEnabled=false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.resquestToken(self.password.text!)
        })
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


