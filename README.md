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

# eGEN API Usage
## Setup
[Gradle 7.0.2](https://docs.gradle.org/7.0.2/release-notes.html) or higher is required.
### Step1: In the root build.gradle add the below code at the end of repositories:
```
allprojects {
		repositories {
			...
			maven { url 'https://jitpack.io' }
		}
	}
```
### Step2: Add the dependency:
```
dependencies {
	        implementation 'com.github.Kowndinya2000:Battery-Aware-API:1.0.2'
	}
```
### Step3: Call the API functions in your source code by extending the ````AdaptationActivity````:
```

```
# How to Contact?
For more information about the project and support requests, feel free to contact Marimuthu C (cs15fv08.muthu@nitk.edu.in) and Sridhar Chimalakonda (ch@iittp.ac.in). Please open an issue or pull request if you find any bug or have an idea for enhancement. 

## License
[MIT](https://choosealicense.com/licenses/mit/)
