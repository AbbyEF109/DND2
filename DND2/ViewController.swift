//
//  ViewController.swift
//  DoNotDisturb
//
//  Created by Abby on 7/12/16.
//  Copyright © 2016 AbbyEF109. All rights reserved.
//

import UIKit
//import RealmSwift
//import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet var setAlarm: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        datePicker.datePickerMode = .DateAndTime
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        //registering for sending user various kinds of notifications
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound|UIUserNotificationType.Alert |UIUserNotificationType.Badge, categories: nil)
            // Override point for customization after application launch.
            return true
    }
    
    @IBAction func alarmButtonTapped(sender: UIButton) {
        scheduleAlarmForDate(datePicker.date)
    }
    
    @IBAction func datePickerSelected(sender: UIDatePicker) {
        //Code to save alarm
        
        
        
        
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
        alarm.soundName = "alarmsound.caf"
        alarm.alertBody = "Time to wake up!"
        app.scheduleLocalNotification(alarm)
        print("setting alarm")
        
    }
    
    
    
    

    // Mute/unmute
    //var value: Float = 0.0
    //AudioSessionSetProperty(kAudioSessionProperty_CurrentHardwareOutputVolume, sizeof(), value)
    
    
    //Alarm tones to come later
    
    
}

