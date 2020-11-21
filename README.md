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
1. Downloand and install Eclipse and Xtext 2.23.0
2. Open Eclipse and create a new Xtext project
3. Use the following settings:
    - **main project name**: org.adaptiveframework.toolsupport.Dsl
    - **language name**: org.adaptiveframework.toolsupport.Dsl
    - **dsl-file extension**: egen
    - **create generator project**: yes
4. Open org.adaptiveframework.toolsupport.Dsl\src\org\adaptiveframework\toolsupport\Dsl.xtext , erase its entire contents and enter the contents of *Dsl.xtext* file.
5. Right click *Dsl.xtext* -> Run As -> Generate Xtext Artifacts
6. Right click *GenerateDsl.mwe2* -> Run As -> MWE2 Workflow
7. Open org.adaptiveframework.toolsupport.Dsl\xtend-gen\org\adaptiveframework\toolsupport\generator\DslGenerator.java, erase the contents and enter the contents of *DslGenerator.xtend* file
8. Right click *org.adaptiveframework.toolsupport.Dsl* -> Run As -> Eclipse Application
9. You will be redirected to a new Eclipse window
10. In a new Eclipse instance, create a new *General* project and create a new file with *.egen* extension to write adaptation policy
11. Write adaptation policy. A sample is given below:
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
12. Save the file. Java code will be automatically generated
13. Use it in the existing Android app project
For more information, visit the video tutorial: https://youtu.be/axPHOUDMuUo

# How to Contact?
For more information about the project and support requests, feel free to contact Marimuthu C (cs15fv08.muthu@nitk.edu.in) and Sridhar Chimalakonda (ch@iittp.ac.in). Please open an issue or pull request if you find any bug or have an idea for enhancement. 
