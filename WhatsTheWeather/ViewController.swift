//
//  ViewController.swift
//  WhatsTheWeather
//
//  Created by Pranav Kasetti on 30/11/2015.
//  Copyright © 2015 Pranav Kasetti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBAction func getWeather(sender: AnyObject) {
        
        //Commented out is my attempt. The uncommented code is by Rob
        
        //var url = NSURL(string: "http://www.weather-forecast.com/locations/\(textField.text!)/forecasts/latest".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        
        //let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            //(data, response, error) in
            
            //if error == nil {
                
                //var urlContent = NSString(data: data!,encoding: NSUTF8StringEncoding)
                
                //var startString = urlContent!.componentsSeparatedByString("<span class=\"phrase\">")[1]
                
                //var finalString = startString.componentsSeparatedByString("</span>")[0]
                
                //self.weatherLabel.text = finalString
            //}
            
        //}
        
        //task.resume()
        
        var url = NSURL(string: "http://www.weather-forecast.com/locations/" + textField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if url != nil {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                
                var urlError = false
                
                var weather = ""
                
                if error == nil {
                    
                    var urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    
                    var urlContentArray = urlContent?.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray!.count > 0 {
                        
                        var weatherArray = urlContentArray![1].componentsSeparatedByString("</span>")
                        
                        weather = weatherArray[0] as String
                        
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                    } else {
                        
                        urlError = true
                        
                    }
                    
                } else {
                    
                    urlError = true
                    
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if urlError == true {
                        
                        self.showError()
                        
                    } else {
                        
                        self.weatherLabel.text = weather
                        
                    }
                }
                
            })
            
            task.resume()
            
        } else {
            
            showError()
            
        }
        
    }
    
    func showError() {
        
        weatherLabel.text = "Was not able to find weather for " + textField.text! + ". Please try again."
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

