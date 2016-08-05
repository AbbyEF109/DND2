
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
import Mixpanel

class AlarmViewController: UIViewController {
    
    @IBOutlet var setAlarm: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    var soundApp = AVAudioPlayer()
    let notification = UILocalNotification()
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    let app: UIApplication = UIApplication.sharedApplication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.datePicker.datePickerMode = .DateAndTime
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.fireAlarm), name: "AlarmNotification", object: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openSettingsButtonPressed(sender: UIButton) {
        mixpanel.track("Button pushed", properties: ["Button" : "Settings Button"])
        let URL: NSURL = NSURL(string: "prefs:root=General")!
        UIApplication.sharedApplication().openURL(URL)
    }
    
    @IBAction func alarmButtonTapped(sender: UIButton) {
        self.scheduleNotificationForDate(datePicker.date)
        self.setAlarmTapNoise()
        //self.alarmForDate(datePicker.date)
        mixpanel.track("Button pushed", properties: ["Button" : "Set Alarm"])
        
    }
    
    @IBAction func datePickerSelected(sender: UIDatePicker) {
        mixpanel.track("Button pushed", properties: ["Button" : "Date Picker"])
    }
    
    func setAlarmTapNoise(){
        let path = "/System/Library/Audio/UISounds/dtmf-3.caf"
        let url = NSURL(fileURLWithPath: path)
        do {
            self.soundApp = try AVAudioPlayer(contentsOfURL: url)
            self.soundApp.play()
            //let testSoundApp = self.soundApp.play()
            //print(testSoundApp)
            //print("sounds play now yay")
            //Alert that gives the user directions to use the app optimally
            let alertController = UIAlertController(title: "Alarm set!", message:"Tap the Edit Settings button. Set your phone on Airplane Mode, and the app will go off until you tap the Stop Alarm button to make sure you get up. Rest well!", preferredStyle: UIAlertControllerStyle.Alert)
            let cancel = UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancel)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
            
        catch {
            print("There was an error accessing the sound.")
        }
        
    }
    //Set notifications for time from Date Picker
    func scheduleNotificationForDate(fixedDate: NSDate) {
        //Where the alarm time will persist (NSUserDefaults)
        let defaults = NSUserDefaults.standardUserDefaults()
        let pickedDate = datePicker.date
        //To get rid of the pesky extra 14 second problem - floors it and sets seconds to 0
        let floorDate = floor(pickedDate.timeIntervalSinceReferenceDate/60.0) * 60.0
        let fixedDate = NSDate(timeIntervalSinceReferenceDate: floorDate)
        //Persist the alarm time
        defaults.setObject(fixedDate, forKey: "savedFixedDate")
        let sFD = defaults.objectForKey("savedFixedDate") as? NSDate ?? NSDate()
        // Create a new notification.
        let notification = UILocalNotification()
        //print("This is the sFD")
        //print(sFD)
        notification.fireDate = NSDate(timeInterval: 0, sinceDate: sFD)
        //print("This is the fireDate")
        //print(notification.fireDate)
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.repeatInterval = NSCalendarUnit(rawValue: 0)
        notification.soundName = "bell.mp3"
        notification.alertBody = "Time is up! Don't forget to turn off Airplane Mode and to hit Stop Alarm!"
        app.scheduleLocalNotification(notification)
        print("First notification set!")
        //To set up repeating notifications
        var myDouble: Double = 13 //bell.mp3 is 13 seconds long
        var notificationCounter: Int = 1
        while notificationCounter < 65 /*64 is max allowed */ {
                let datePlusOneMinute: NSDate = sFD.dateByAddingTimeInterval(myDouble)
                //print("This is the sFD")
                //print(sFD)
                notification.fireDate = NSDate(timeInterval: 0, sinceDate: datePlusOneMinute)
                //print("This is the fireDate")
                //print(notification.fireDate)
                notification.timeZone = NSTimeZone.defaultTimeZone()
                notification.repeatInterval = NSCalendarUnit(rawValue: 0)
                notification.soundName = "bell.mp3"
                notification.alertBody = "Time is up! Don't forget to turn off Airplane Mode!"
                app.scheduleLocalNotification(notification)
                print("Another notification set!")
                notificationCounter += 1
                //print("This is the notification counter")
                //print(notificationCounter)
                myDouble += 13 //Added to the time each repetition - alarm loops continuously
                //print("This is myDouble")
                //print(myDouble)
            }
        }
    //Tied to UINotificationCenter
    func fireAlarm() {
        //print("fireAlarm")
        //Points to where the alarm sound is located
        let path = NSBundle.mainBundle().pathForResource("bell", ofType: "mp3")
        let url = NSURL(fileURLWithPath: path!)
        do {
            self.soundApp = try AVAudioPlayer(contentsOfURL: url)
            self.soundApp.play()
            //let testSoundApp = self.soundApp.play()
            //print(testSoundApp)
            //Sound repeats infinitely until stopped
            self.soundApp.numberOfLoops = -1
            //print("sounds play now yay 2")
            //sends the user to their settings
            let URL: NSURL = NSURL(string: "prefs:root=General")!
            UIApplication.sharedApplication().openURL(URL)
        }
        catch {
            print("There was an error accessing the sound.")
        }
    }
    
    
    @IBAction func stopAlarm(sender: AnyObject) {
        mixpanel.track("Button pushed", properties: ["Button" : "Stop Alarm"])
        let oldNotifications: [UILocalNotification] = app.scheduledLocalNotifications!
        //Clear out the old notification before scheduling a new one.
        if oldNotifications.count > 0 { app.cancelAllLocalNotifications()}
        //Stops alarm noise
        self.soundApp.stop()
    }
}