# eGEN
A tool to specify energy-aware self-adaptive location-sensing strategies
# eGEN Overview
Add Diagram
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
# How to Install?
1. Downloand Java 1.6 and Eclipse Juno (>= 4.2) with Xtext 2.0
2. Open Eclipse and go to Help > Install New Software…
3. Add the URL of update site:
4. Select *e*GEN
5. Countinue to install
# How to use?
1. Create a new *e*GEN project
2. Create a new file with .egen extension
3. Write adaptation policy
4. Generate the Java code
5. Use it in the existing Android app project

For more information: 
# How to Contact?
For more information about the project and support requests, feel free to contact Marimuthu C (cs15fv08.muthu@nitk.edu.in) and Sridhar Chimalakonda (ch@iittp.ac.in). Please open an issue or pull request if you find any bug or have an idea for enhancement. 
