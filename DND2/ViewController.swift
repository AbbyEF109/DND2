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
// Need to import AVAudioPlayer somehow
    
    
    @IBOutlet var setAlarm: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    //init(data 1005)
    var numberOfLoops: Int?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        datePicker.datePickerMode = .DateAndTime
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func alarmButtonTapped(sender: UIButton) {
        scheduleAlarmForDate(datePicker.date)
        soundAlarmForDate(datePicker.date)
        
    }
    
    @IBAction func datePickerSelected(sender: UIDatePicker) {
        //Code to save alarm
        
        
        
        
    }
    
    func soundAlarmForDate(theDate: NSDate) {
        let path = "/System/Library/Audio/UISounds/dtmf-3.caf"
        let url = NSURL(fileURLWithPath: path)
        do {
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
        alarm.soundName = "1005"
        alarm.alertBody = "Time to wake up!"
        
        app.scheduleLocalNotification(alarm)
        print("Alarm set!")
        
    }
    
    
    
    

    // Mute/unmute
    //var value: Float = 0.0
    //AudioSessionSetProperty(kAudioSessionProperty_CurrentHardwareOutputVolume, sizeof(), value)
    
    
    //Alarm tones to come later
    
    
}

