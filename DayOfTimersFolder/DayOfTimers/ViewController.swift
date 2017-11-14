//
//  ViewController.swift
//  DayOfTimers
//
//  Created by Quinton Quaye on 6/7/17.
//  Copyright © 2017 Quinton Quaye. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    @IBOutlet weak var forTodayLabel: UILabel!
    
    @IBOutlet weak var totalTimeAwake: UILabel!
    @IBOutlet weak var totalTimeSleep: UILabel!
    @IBOutlet weak var wakeTime: UILabel!


    
    @IBOutlet weak var sleepTime: UILabel!
    @IBOutlet weak var waterTimes: UILabel!
    @IBOutlet weak var peeTimes: UILabel!
    @IBOutlet weak var poopTimes: UILabel!
    @IBOutlet weak var exerciseTimes: UILabel!
    @IBOutlet weak var sexTimes: UILabel!
    @IBOutlet weak var batheTimes: UILabel!
    @IBOutlet weak var eatTimes: UILabel!
   
    
    
    
    @IBOutlet weak var wakeTimeTextField: UITextField!
    @IBOutlet weak var sleepTimeTextField: UITextField!
    
   
    //Variables//
    //sleep//
    
    var day: Double = Double(24.0)
    
    let hour: Double = Double(3600.0)// in minutes
    let minute: Double = Double(60.0)//in seconds
    let noon: Double = Double(12.0)
    //the amount of times you need to pee in the day//
    
    
    
    // integer labels for counting//
    
    var totalTimeAwakeInt: Double = Double(Int())
    var totalTimeSleepInt: Double = Double(Int())
    var wakeTimeInt: Double = Double(Int())
    var sleepTimeInt: Double = Double(Int())
    var waterTimesInt: Double = Double(Int())
    var peeTimesInt: Double = Double(Int())
    var poopTimesInt: Double = Double(Int())
    var exerciseTimesInt: Double = Double(Int())
    var sexTimesInt: Double = Double(Int())
    var batheTimesInt: Double = Double(Int())
    var eatTimesInt: Double = Double(Int())
    
    
    
    
    
    var myWaterTimes: Double = Double(Int())
    var myPeeTimes: Double = Double(Int())
    var myPoopTimes: Double = Double(Int())
    var myExerciseTimes: Double = Double(Int())
    var mySexTimes: Double = Double(Int())
    var myBatheTimes: Double = Double(Int())
    var myEatTimes: Double = Double(Int())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    forTodayLabel.text = ""
        
        
        // the item equaling itsself through TextfieldDelegate//
        wakeTimeTextField.delegate = self
        sleepTimeTextField.delegate = self
        /////////
        
        myWaterTimes = 16
        myPeeTimes = 16
        myPoopTimes = 1
        myExerciseTimes = 1
        mySexTimes = 1
        myBatheTimes = 1
        myEatTimes = 3
        
    }
    
    
    
    
    
    
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard. and allows the textField to be hit with the return button to post the text in the field//
        textField.resignFirstResponder()
        return true
        
    }
    @IBAction func enterButton(_ sender: UIButton) {
        forTodayLabel.text = "For Today:"
        
        // amount of time awake//
        wakeTimeInt = Double(wakeTimeTextField.text!)!
        print(wakeTimeInt)
        
        wakeTime.text = "\(wakeTimeInt)"
        
        sleepTimeInt = Double(sleepTimeTextField.text!)!
        print(sleepTimeInt)
        sleepTime.text = "\(sleepTimeInt)"
        
        totalTimeAwakeInt = sleepTimeInt - wakeTimeInt
        
        totalTimeAwake.text = "\(totalTimeAwakeInt)"
        
        if sleepTimeInt > noon {
            sleepTime.text = "\(sleepTimeInt - 12.0)"
        }
        
        if wakeTimeInt > noon {
            wakeTime.text = "\(wakeTimeInt - 12.0)"
        }
        
        // amount of time sleep//
        if sleepTimeInt < wakeTimeInt {
            totalTimeSleepInt = wakeTimeInt - sleepTimeInt
            totalTimeAwakeInt = (sleepTimeInt - wakeTimeInt) + day
            totalTimeAwake.text = "\(totalTimeAwakeInt) hrs."
            //////// state the time for sleep////
            totalTimeSleepInt = day - totalTimeAwakeInt
            totalTimeSleep.text = "\(totalTimeSleepInt as NSNumber) hrs."
        }else {
            //////// Restate the time for sleep but the awake time will stay as previous in the awake field////
            totalTimeSleepInt = day - totalTimeAwakeInt
            totalTimeSleep.text = "\(totalTimeSleepInt) hrs."
            
        }
        
        //////////////////////////// End
        
        
        
        
        // functions...
        func dividedBy60(num1: Double, num2: Double) -> Double{
            return num1 / num2
        }
        
        func dividedBy3600(num1: Double, num2: Double) -> Double{
            return num1 / num2
        }
        
        func availableActionHours(num1: Double, num2: Double, num3: Double) -> Double{
            return num1 * num2 / num3
        }
        
        
        func delegateMinsAndHours(num1: Double) -> String{
            var label = ""
            // for min
            if num1 > 60{
                label = "every \(Int(round(1.0 * dividedBy60(num1: num1, num2: 60)))) hrs."
                print("this is for min \(dividedBy60(num1: num1, num2: 60))")
            } else {
                label = "within every \(Int(num1)) hours."
                print("this is for hour \(num1)")
            }
            
            /*// for hour
            if num1 >= hour{
                label = "every \(Int(round(1.0 * dividedBy3600(num1: num1, num2: hour)))) hrs."
            }
            */
            return label
        }
        
        // end of functions...
        
        // drink water//
        
        // the time you can pee in a day "time listed in seconds"//
        waterTimesInt = round(100.0 * totalTimeAwakeInt / myWaterTimes)
        print(waterTimesInt)
        
      
        waterTimes.text = delegateMinsAndHours(num1: waterTimesInt)
    
        
      
        //(in seconds  unless ** if timeYouGotoSleep is less than timeYouAwake will be displayed in hours)
        
        // the time you can pee in a day "time converted in minnutes"//
        
        var drinkWaterTime = dividedBy60(num1: waterTimesInt, num2: minute) //(in minutes)
        
        availableActionHours(num1: drinkWaterTime, num2: myWaterTimes, num3: hour)
        //(in hours) should be equal to the amount of time you are awake!
        
        
        //////////////////////////// End
        
        
        // pee//
        // the time you can pee in a day "time listed in seconds"//
        
        peeTimesInt = round(100.0 * totalTimeAwakeInt / myPeeTimes)
        
        peeTimes.text = delegateMinsAndHours(num1: peeTimesInt)//(in seconds  unless ** if timeYouGotoSleep is less than timeYouAwake will be displayed in hours)
        
        // the time you can pee in a day "time converted in minnutes"//
        var peeTime = peeTimesInt * minute //(in minutes)
        
        var availablePeeHours = peeTime * myPeeTimes / hour //(in hours) should be equal to the amount of time you are awake!
        
        //////////////////////////// End
        
        
        // poop//
        
        poopTimesInt = totalTimeAwakeInt / myPoopTimes
        
        poopTimes.text = delegateMinsAndHours(num1: poopTimesInt)//(every # hours go poop.)
        
        print(poopTimes)
        
        // the time you can pee in a day "time converted in minnutes"//
        var poopTime = poopTimesInt * minute
        //(in minutes)
        
        var availablePoopHours = poopTime * myPoopTimes / hour //(in hours) should be equal to the amount of time you are awake!
        
        //////////////////////////// End

        
        // Exercise//
        // the time you can pee in a day "time listed in seconds"//
        exerciseTimesInt = totalTimeAwakeInt / myExerciseTimes
        
        exerciseTimes.text = delegateMinsAndHours(num1: exerciseTimesInt)//(in seconds  unless ** if timeYouGotoSleep is less than timeYouAwake will be displayed in hours)
        
        // the time you can pee in a day "time converted in minnutes"//
        var exerciseTime = exerciseTimesInt * minute //(in minutes)
        
        var availableExerciseHours = exerciseTime * myExerciseTimes / hour //(in hours) should be equal to the amount of time you are awake!
        
        //////////////////////////// End
        
        // Sex//
        // the time you can pee in a day "time listed in seconds"//
        sexTimesInt = totalTimeAwakeInt / mySexTimes
        sexTimes.text = delegateMinsAndHours(num1: sexTimesInt)//(in seconds  unless ** if timeYouGotoSleep is less than timeYouAwake will be displayed in hours)
        
        // the time you can pee in a day "time converted in minnutes"//
        var sexTime = sexTimesInt * minute //(in minutes)
        
        var availableSexHours = sexTime * mySexTimes / hour //(in hours) should be equal to the amount of time you are awake!
        
        //////////////////////////// End
        
        // Bathing//
        // the time you can pee in a day "time listed in seconds"//
        batheTimesInt = totalTimeAwakeInt / myBatheTimes
        batheTimes.text = delegateMinsAndHours(num1: batheTimesInt)//(in seconds  unless ** if timeYouGotoSleep is less than timeYouAwake will be displayed in hours)
        
        // the time you can pee in a day "time converted in minnutes"//
        var batheTime = batheTimesInt * minute //(in minutes)
        var availableBathingHours = batheTime * myBatheTimes / hour //(in hours) should be equal to the amount of time you are awake!
        
        //////////////////////////// End
        
        // Eating//
        
        eatTimesInt = round(totalTimeAwakeInt / myEatTimes)
        eatTimes.text = delegateMinsAndHours(num1: eatTimesInt)//(every # hours go eat.)
        
        // the time you can pee in a day "time converted in minnutes"//
        var eatTime = eatTimesInt * minute //(in minutes)
        
        var availableEatHours = eatTime * myEatTimes / hour //(in hours) should be equal to the amount of time you are awake!
    
        
        // for time indicators//
        // wake time//
        if wakeTimeInt < 12 {
            wakeTime.text = "\(String(describing:wakeTimeInt as NSNumber)) a.m."
        } else {
            wakeTime.text = "\(String(describing:wakeTimeInt as NSNumber)) p.m."
        
        }
        if wakeTimeInt == 24 {
            wakeTime.text = "\(String(describing:wakeTimeInt as NSNumber)) a.m."
        }
        
        // sleep time//
        if sleepTimeInt < 12 {
            sleepTime.text = "\(String(describing:sleepTimeInt as NSNumber)) a.m."
        } else {
            sleepTime.text = "\(String(describing:sleepTimeInt as NSNumber)) p.m."
            
        }
        if sleepTimeInt == 24 {
           sleepTime.text = "\(String(describing:sleepTimeInt as NSNumber)) a.m."
        }
    
    
    
    
    ////////////////when to fire the notifications///////////
    
        

    
    }///// end of execute button////////
    
}
