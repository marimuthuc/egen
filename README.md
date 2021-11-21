# eGEN
A tool to specify energy-aware self-adaptive location-sensing strategies of smartphone applications. It contains a textual domain-specific modeling language and code generator that covers the domain-specific concepts of location-based applications.
# eGEN Overview
*e*GEN is developed using *Xtext* and *Xtend* as an Eclipse plugin. *e*GEN is targeted for *Domain Analyst* and *Developer*. As shown in Figure, the use of *e*GEN consists of seven steps. 
![Image of eGEN Eco-system](https://github.com/marimuthuc/egen/blob/main/egen-eco-system.png)
*e*GEN is designed to give domain analysts options to assign values for *critical battery level, and sensing-interval* based on the application requirements. Further, the code generator of *e*GEN generates the Java code for developers that could be added to the existing Android repositories to make them battery-aware.

# Language Description
Language Element | Category | Description | Allowed Values
------------ | ------------- | -------------- | ------------
BatteryState | Context | refers to the remaining battery percentage of the smartphone | Foreground or Background
BatteryLevel | Context | refers to the charging or discharging status of the smartphone | Charging or Discharging
AppState  | Context | refers to the background or foreground execution of the application | Foreground or Background
Threshold_High | Context | used to assign High value for BatteryLevel | Any numerical value
Threshold_Medium | Context | used to assign Medium value for BatteryLevel | Any numerical value
SensingInterval | Feature | refers to the time difference between two subsequent location-sensing requests | Numerical value in milliseconds
DecreasingFactor | Feature | refers to the numerical value that will be used in BatteryAwareFunction | Any numerical value
BatteryAware Function | Feature | refers to the type of change (exponential or linear) in fixing the sensing interval | Numerical value
AdaptationPolicy | Keyword | refers to the definition of adaptation policy | Contains combination of Condition and Adaptation
Condition | Keyword | refers to the definition of context values | Contains the allowed context values
then | Keyword | A separator to differentiate context and feature | NA
Adaptation | Keyword | refers to the definiton of features | Contains all allowed feature values
AND | Keyword | Used to separate each context values and feature values | NA
## Sample Adaptation Policy
```sh
AdaptationPolicy 01 {
    Condition {
        BatteryState = Discharging  AND
        BatteryLevel = Low AND
        Threshold_High = 63 AND
        Threshold_Medium = 46 AND
        AppState = Background 
    } then
    Adaptation {
        SensingInterval = 250 AND
        Decreasing_Factor = 20 AND
        BatteryAwareFunction = Linear 
    }
}
```
# How to Use?
## We have uploaded instructional videos on youtube.
## Please watch the [first](https://youtu.be/Pp8I-Jsc3kI) youtube video to do the following:
###     Download the latest [Eclipse IDE Installer](https://www.eclipse.org/downloads/) 
###     Download the [Java JDK 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html)
## Please watch the [second](https://youtu.be/RrPCjtK3UIc) youtube video to do the following:
### Installation and Setup 
    > Install the IDE for DSL developers
    > Create a Xtext Project
    > Write DSL grammar 
    > Write the necessary Xtend code
### Use the framework to generate code
    > Launch Eclipse Application to test the framework
    > Create a sample project
    > Write a sample adaptation policy 
    > Generate Java templates containing code for self-adaptive location-sensing 

# Exact Adaptation Policy Instrumented for Subject Applications
```sh
AdaptationPolicy 01 {
    Condition {
        BatteryState = Discharging  AND
        BatteryLevel =  High AND
        Threshold_High = 80 AND
        Threshold_Medium = 50 AND
        AppState = Foreground 
    } then
    Adaptation {
        SensingInterval = 3000 AND
        Decreasing_Factor = 10 AND
        BatteryAwareFunction = Linear 
    }
}
AdaptationPolicy 02 {
    Condition {
        BatteryState = Discharging  AND
        BatteryLevel =  Medium AND
        Threshold_High = 80 AND
        Threshold_Medium = 50 AND
        AppState = Foreground 
    } then
    Adaptation {
        SensingInterval = 4000 AND
        Decreasing_Factor = 20 AND
        BatteryAwareFunction = Linear 
    }
}
AdaptationPolicy 03 {
    Condition {
        BatteryState = Discharging  AND
        BatteryLevel =  Low AND
        Threshold_High = 80 AND
        Threshold_Medium = 50 AND
        AppState = Foreground 
    } then
    Adaptation {
        SensingInterval = 5000 AND
        Decreasing_Factor = 30 AND
        BatteryAwareFunction = Linear 
    }
}
```
## Design rationale behind the Adaptation Policies
```
Android device at any instant of time can be subjected to the following exhaustive list of cases: 
    
    Case1: Battery is discharging and the subject application is in the foreground
    Case2: Battery is discharging and the subject application is in the background
    Case3: Battery is charging and the subject application is in the foreground
    Case4: Battery is charging and the subject application is in the background 

When the device is subjected to experimentation, the maximum battery consumption can be found in Case1 followed by Case2, 3 and 4. 
The subject application trails were executed when the battery is discharging and the application is in the foreground (Case1). 
A GPS sensing interval of 1 or 2 seconds helps in producing accurate distance measurement, and increasing the value to more than 10 seconds worsens the accuracy of the distance measurement for the length of the track we considered (3km),
hence for the non-eGEN version of the subject application we have decided to set sensing interval to 5 seconds that can help in achieving decent accuracy. 
For eGEN versions of subject applications, We have designed simple adaptation policies that tend to reduce the battery consumption as the battery level decreases, hence when the battery is high (greater than 80\%) the defined adaptation policy focuses more on producing accurate location than saving battery and this trend reverses as battery transitions to lower levels. 
The sensing interval behavior with respect to battery level of the device is plotted in the below figure. 
Since, we are confining to a GPS relaxation time of 5 sec (for non-eGEN) to not compromise on location accuracy, we decided to draft the adaptation policies such that the varying sensing interval values when averaged for all the battery levels from zero to hundred would be close to 5000ms. 
The average sensing interval as calculated is 5666ms and we have shown in the below sections that savings have been reported through adaptation policies defined without losing the much of location accuracy when compared to Non-eGEN version.     
```
## Sensing interval impacted by the change in battery level
![Sensing Interval Behavior based on the chosen Adaptation Policies](https://github.com/marimuthuc/egen/blob/main/chart.png)

# How to Contact?
For more information about the project and support requests, feel free to contact Marimuthu C (cs15fv08.muthu@nitk.edu.in) and Sridhar Chimalakonda (ch@iittp.ac.in). Please open an issue or pull request if you find any bug or have an idea for enhancement. 

## License
[MIT](https://choosealicense.com/licenses/mit/)
