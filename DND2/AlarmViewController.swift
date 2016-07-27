//
//  ViewController.swift
//  DoNotDisturb
//
//  Created by Abby on 7/12/16.
//  Copyright © 2016 AbbyEF109. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox
import AVFoundation

//import RealmSwift


class AlarmViewController: UIViewController {
    
    @IBOutlet var setAlarm: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    
    var soundApp = AVAudioPlayer()
    let notification = UILocalNotification()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.soundAlarmForDate(datePicker.date)
        // Do any additional setup after loading the view, typically from a nib.
        self.datePicker.datePickerMode = .DateAndTime
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.fireAlarm), name: "AlarmNotification", object: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openSettingsButtonPressed(sender: AnyObject) {
//        let URL: NSURL = NSURL(string: UIApplicationOpenSettingsURLString)!
        let URL: NSURL = NSURL(string: "prefs:root=General")!
        UIApplication.sharedApplication().openURL(URL)
    }
    
    
    /*func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .Main, closure: () -> Void) {
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatchLevel.dispatchQueue, closure)
    }
    
    enum DispatchLevel {
        case Main, UserInteractive, UserInitiated, Utility, Background
        var dispatchQueue: OS_dispatch_queue {
            switch self {
            case .Main:             return dispatch_get_main_queue()
            case .UserInteractive:  return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
            case .UserInitiated:    return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
            case .Utility:          return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)
            case .Background:       return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0) }
        }
    }*/
    
    @IBAction func alarmButtonTapped(sender: UIButton) {
        self.scheduleNotificationForDate(datePicker.date)
        self.setAlarmTapNoise()
        //self.alarmForDate(datePicker.date)
        
    }
    
    @IBAction func datePickerSelected(sender: UIDatePicker) { //Not needed?
        //Code to save alarm
        //reference to NSUserDefaults (instance of the class)
        //WIP
        /*let defaults = NSUserDefaults.standardUserDefaults()
        print("This is from NSUserdefaults")
        defaults.setObject(NSDate(), forKey: "Date")
        let pickedDate = defaults.objectForKey("Date") as? NSDate ?? NSDate()
        print(pickedDate)
        
        print("Ends NSUserDefaults")*/
        
        //defaults.setObject(NSDate(), forKey: "Date")
        //let getDate = defaults.objectForKey("Date") as? NSDate ?? NSDate()
        //print(getDate)
        //WORKS!!!!!
        /*
         defaults.setObject("iOS-Blog", forKey: "Name")
         let array_get = defaults.objectForKey("Name") as? [String] ?? [String]()
         print(array_get)
         prints an empty array
        defaults.setObject(NSDate(), forKey: "Date")
        let getDate = defaults.objectForKey("Date") as? [String] ?? [String]()
        defaults.synchronize()
        print(getDate)
        prints empty array -_-;
        let dict = ["Name": "iOS-Blog", "tagline": "Awesome Tutorials", "rating": "10/10"]
        defaults.setObject(dict, forKey: "SavedDict")
        let savedDict = defaults.objectForKey("SavedDict") as? [String: String] ?? [String: String]()
        print(savedDict)
        well at least the example works... */
        /*let aDict: Dictionary = ["fireDate": NSDate, "timeZone": NSDate, "repeatInterval": Int, "soundName": String, "alertBody": String]
        defaults.setObject(aDict, forKey: "alarmDict")
        let dict = defaults.objectForKey("alarmDict") as? [String: String] ?? [String: String]()
        print(dict)*/
        //ARGH
        /*defaults.setObject(NSDate(), forKey: "now")
        let getNow = defaults.objectForKey("now") as? [String] ?? [String]()

        print(getNow)
        */
        //Let's try this again...
        //let DatePickerDate: NSDate = datePicker.date
        //defaults.setObject(NSDate(), forKey: "DatePickerDate")
        //func setObject(_: datePicker.date: AnyObject?, forKey datePickerDate: String)
        //func set(_: datePicker.date: AnyObject?, forKey datePickerDate)
        //Not working
        //default.setObject(datePicker.date, forKey date)
        //Says default can only be used in switch statement for some reason
        /*func set(_: anyObject? forKey: String){
            defaults.setObject(datePicker.date, forKey: datePickerDate)
        } Also not working*/
        
    }
    
    func setAlarmTapNoise(){
        let path = "/System/Library/Audio/UISounds/dtmf-3.caf"
        let url = NSURL(fileURLWithPath: path)
        do {
            //let soundApp = try AVAudioPlayer(contentsOfURL: url)
            self.soundApp = try AVAudioPlayer(contentsOfURL: url)
            self.soundApp.play()
            let testSoundApp = self.soundApp.play()
            print(testSoundApp)
            //self.soundApp.numberOfLoops = 3
            print("sounds play now yay")
            let alertController = UIAlertController(title: "Alarm set!", message:"Lock your phone or go to the home screen and the alarm will do the rest. Rest well!", preferredStyle: UIAlertControllerStyle.Alert)
            let cancel = UIAlertAction(title: "Cool!", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancel)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
            
        catch {
            print("There was an error accessing the sound.")
        }
        
    }
    
   // func alarmForDate(pickedDate: NSDate) {
        //let defaults = NSUserDefaults.standardUserDefaults()
        //let pickedDate = datePicker.date
        //print("This is the picked date:")
        //print(pickedDate)
        //print("This is the notification date:")
        //let setDate = notification.fireDate
        //print(setDate)
        //print("This is pickedDate")
        //print(pickedDate)
        //print("This is from NSUserdefaults")
        //defaults.setObject(pickedDate, forKey: "savedPickedDate")
        //let sPD = defaults.objectForKey("savedPickedDate") as? NSDate ?? NSDate()
        //print(sPD)
        //print("Ends NSUserDefaults")
        
        //let now = NSDate()
        //print("This is now")
        //print(now)
        
        /*while(sPD != now){
            sleep(1)
        }*/
        
        /*while(sPD != now){
            var timer = NSTimer()
            let delay = 0.1
            timer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
        }*/
        
        /*while(sPD != now){
            
        }*/
        
        //print("PickedDate works!")
        
        /*while(sPD != now){
         sleep(1)
         }*/
        
        /*while (sPD != now){
         delay(bySeconds: 1, dispatchLevel: .Background) {
         while (sPD = now){
         
         }
         }
         }*/
        /*while (sPD != now){
         //var delayTimer = NSTimer()
         let myTimer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(, target: self, selector: Selector("alarmForDate"), userInfo: nil, repeats: false)
         
         }*/
        
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let pickedDate = datePicker.date
//        defaults.setObject(pickedDate, forKey: "savedPickedDate")
//        let sPD = defaults.objectForKey("savedPickedDate") as? NSDate ?? NSDate()
//        let now = NSDate()
        
        
//        
//        let path = "/System/Library/Audio/UISounds/dtmf-3.caf"
//        //let path = NSBundle.mainBundle().pathForResource("tickle", ofType: "mp3")
//        let url = NSURL(fileURLWithPath: path)
//        
//        do {
            //let soundApp = try AVAudioPlayer(contentsOfURL: url)
//            self.soundApp = try AVAudioPlayer(contentsOfURL: url)
//            self.soundApp.play()
//            let testSoundApp = self.soundApp.play()
//            print(testSoundApp)
//            self.soundApp.numberOfLoops = 3
//            print("sounds play now yay")
//            let alertController = UIAlertController(title: "Are you up now?", message:"Do you want to turn off the ringtone?", preferredStyle: UIAlertControllerStyle.Alert)
//            let cancel = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Cancel, handler: nil)
//            alertController.addAction(cancel)
//            self.presentViewController(alertController, animated: true, completion: nil)
//        }
//            
//            
//        catch {
//            print("There was an error accessing the sound.")
//        }
//    }

    //Set the alarm based on the data given by user via date picker

    func scheduleNotificationForDate(setDate: NSDate) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let pickedDate = datePicker.date
        defaults.setObject(pickedDate, forKey: "savedPickedDate")
        let sPD = defaults.objectForKey("savedPickedDate") as? NSDate ?? NSDate()
        let now = NSDate()
        let app: UIApplication = UIApplication.sharedApplication()
        let oldNotifications: [UILocalNotification] = app.scheduledLocalNotifications!
        // Clear out the old notification before scheduling a new one.
        if oldNotifications.count > 0 { app.cancelAllLocalNotifications() }
        // Create a new notification.
        //let notification = UILocalNotification()
        print("This is the sPD")
        print(sPD)
        notification.fireDate = NSDate(timeInterval: 1, sinceDate: setDate)
        print("Tis is the fireDate")
        print(notification.fireDate)
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.repeatInterval = NSCalendarUnit(rawValue: 0)
        //notification.soundName = "tickle.mp3" //works but is stopgap
        notification.alertBody = "Time is up!"
        app.scheduleLocalNotification(notification)
        print("Notification set!")
    }
    
    func fireAlarm() {
        print("fireAlarm")
        //let path = "/System/Library/Audio/UISounds/dtmf-3.caf"
        let path = NSBundle.mainBundle().pathForResource("tickle", ofType: "mp3")
        let url = NSURL(fileURLWithPath: path!)
        do {
            self.soundApp = try AVAudioPlayer(contentsOfURL: url)
            self.soundApp.play()
            let testSoundApp = self.soundApp.play()
            print(testSoundApp)
            self.soundApp.numberOfLoops = 1
            print("sounds play now yay 2")
            let alertController = UIAlertController(title: "Are you up now?", message:"Do you want to turn off the ringtone?", preferredStyle: UIAlertControllerStyle.Alert)
            let cancel = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancel)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        catch {
            print("There was an error accessing the sound.")
        }
    }
    
    
    

//     Mute/unmute
    //var value: Float = 0.0
    //AudioSessionSetProperty(kAudioSessionProperty_CurrentHardwareOutputVolume, sizeof(), value)
    
    
    //Alarm tones to come later?
    
    
}