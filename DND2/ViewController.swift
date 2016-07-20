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


class ViewController: UIViewController {
    
    @IBOutlet var setAlarm: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    //init(data 1005)
    
    var soundApp = AVAudioPlayer()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.soundAlarmForDate(datePicker.date)
        // Do any additional setup after loading the view, typically from a nib.
        datePicker.datePickerMode = .DateAndTime
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func alarmButtonTapped(sender: UIButton) {
        self.scheduleAlarmForDate(datePicker.date)
        self.soundAlarmForDate(datePicker.date)
        
    }
    
    @IBAction func datePickerSelected(sender: UIDatePicker) {
        //Code to save alarm
        //reference to NSUserDefaults (instance of the class)
       let defaults = NSUserDefaults.standardUserDefaults()
        //func set(_: datePicker.date: AnyObject?, forKey datePickerDate)
        //Not working
        //default.setObject(datePicker.date, forKey date)
        //Says default can only be used in switch statement for some reason
        /*func set(_: anyObject? forKey: String){
            defaults.setObject(datePicker.date, forKey: datePickerDate)
        } Also not working*/
    }
    
    func soundAlarmForDate(theDate: NSDate) {
        let path = "/System/Library/Audio/UISounds/dtmf-3.caf"
        //let path = NSBundle.mainBundle().pathForResource("slap", ofType: "mp3")
        let url = NSURL(fileURLWithPath: path)
        do {
            //let soundApp = try AVAudioPlayer(contentsOfURL: url)
            soundApp = try AVAudioPlayer(contentsOfURL: url)
            soundApp.play()
            let testSoundApp = soundApp.play()
            print(testSoundApp)
            soundApp.numberOfLoops = 3
            print("sounds play now yay")
        }
            
        catch {
            print("There was an error accessing the sound.")
        }
        
    }
    
    //Function to make the alarm make noise
    func ssoundAlarmForDate(theDate: NSDate) {
        //theDate = NSDate: datePicker.date
        //let path = "/System/Library/Audio/UISounds/alarm.caf"
        //let path = "/System/Library/Audio/UISounds/New/Fanfare.caf"
        //let path = "/System/Library/Audio/UISounds/ReceivedMessage.caf"
        //let path = "/System/Library/Audio/UISounds/Calypso.caf"
        let path = "/System/Library/Audio/UISounds/dtmf-3.caf"
        //let path = "/System/Library/Audio/UISounds/dtmf-pound.caf"
        //let path = NSBundle.mainBundle().pathForResource("sunshine", ofType: "wav")
        let url = NSURL(fileURLWithPath: path)
        //print(path)
        do {
            //AudioServicesPlaySystemSound (1003) /*
            let soundApp = try AVAudioPlayer(contentsOfURL: url)
            soundApp.play()
            let testSoundApp = soundApp.play()
            print(testSoundApp)
            soundApp.numberOfLoops = 3
            print("sounds play now yay")
        }
        
        catch {
            print("There was an error accessing the sound.")
        }
        
    }
    //Set the alarm based on the data given by user via date picker

    func scheduleAlarmForDate(theDate: NSDate) {
        let app: UIApplication = UIApplication.sharedApplication()
        let oldNotifications: [UILocalNotification] = app.scheduledLocalNotifications!
        // Clear out the old notification before scheduling a new one.
        if oldNotifications.count > 0 { app.cancelAllLocalNotifications() }
        // Create a new notification.
        let alarm = UILocalNotification()
        alarm.fireDate = theDate
        alarm.timeZone = NSTimeZone.defaultTimeZone()
        alarm.repeatInterval = NSCalendarUnit(rawValue: 0)
        alarm.soundName = "1005" //is this needed?
        alarm.alertBody = "Time to wake up!"
        
        app.scheduleLocalNotification(alarm)
        print("Alarm set!")
        
    }
    
    
    
    

    // Mute/unmute
    //var value: Float = 0.0
    //AudioSessionSetProperty(kAudioSessionProperty_CurrentHardwareOutputVolume, sizeof(), value)
    
    
    //Alarm tones to come later?
    
    
}

