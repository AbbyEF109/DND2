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
    var now = NSDate()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.soundAlarmForDate(datePicker.date)
        // Do any additional setup after loading the view, typically from a nib.
        self.datePicker.datePickerMode = .DateAndTime
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func alarmButtonTapped(sender: UIButton) {
        self.scheduleNotificationForDate(datePicker.date)
        self.setAlarmTapNoise()
        self.alarmForDate(self.datePicker.date)
        
    }
    
    @IBAction func datePickerSelected(sender: UIDatePicker) {
        //Code to save alarm
        //reference to NSUserDefaults (instance of the class)
        //WIP
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSDate(), forKey: "now")
        let getNow = defaults.objectForKey("now") as? [String] ?? [String]()
        print("This is from NSUserdefaults")
        print(getNow)
        print("Ends NSUserDefaults")
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
        //pickedDate = datePicker.date
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
    
    func alarmForDate(pickedDate: NSDate) {
        if (pickedDate == now){
            let path = NSBundle.mainBundle().pathForResource("bell", ofType: "mp3")
            let url = NSURL(fileURLWithPath: path!)
        do {
            //let soundApp = try AVAudioPlayer(contentsOfURL: url)
            self.soundApp = try AVAudioPlayer(contentsOfURL: url)
            self.soundApp.play()
            let testSoundApp = self.soundApp.play()
            print(testSoundApp)
            self.soundApp.numberOfLoops = 3
            print("sounds play now yay")
            let alertController = UIAlertController(title: "Are you up now?", message:"Do you want to turn off the ringtone?", preferredStyle: UIAlertControllerStyle.Alert)
            let cancel = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancel)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
            
            
        catch {
            print("There was an error accessing the sound.")
        }
        }
    }

    //Set the alarm based on the data given by user via date picker

    func scheduleNotificationForDate(setDate: NSDate) {
        let app: UIApplication = UIApplication.sharedApplication()
        let oldNotifications: [UILocalNotification] = app.scheduledLocalNotifications!
        // Clear out the old notification before scheduling a new one.
        if oldNotifications.count > 0 { app.cancelAllLocalNotifications() }
        // Create a new notification.
        let notification = UILocalNotification()
        notification.fireDate = setDate
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.repeatInterval = NSCalendarUnit(rawValue: 0)
        notification.soundName = "bell.mp3" //works but is stopgap
        notification.alertBody = "Time is up!"
        app.scheduleLocalNotification(notification)
        print("Notification set!")
        print(setDate)
    }
    
    
    
    

    // Mute/unmute
    //var value: Float = 0.0
    //AudioSessionSetProperty(kAudioSessionProperty_CurrentHardwareOutputVolume, sizeof(), value)
    
    
    //Alarm tones to come later?
    
    
}

