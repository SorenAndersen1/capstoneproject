# Walkthru
> An iOS AR instruction manual app 
> 
![Header For Walkthru](https://github.com/SorenAndersen1/OSUCapstoneProject/blob/main/images/wordart.png?raw=true)

Walkthru is an iOS app taking advantage of Apple's ARKit 3 to recognize images and allow users to complete complex tasks. Walkthru was designed
for Oregon State University's Computer Science Senior Capstone project. To view the engineering expo page for Walkthru click here (Add Link when available).
Walkthru uses the image recognition available in the native AR environment in iOS Swift to recognize photos of distinct points of a guide. An example of a simple
Walkthru is making a Peanutbutter and Jelly sandwich. Walkthru is able to guide users through each ingredient necessary, highlighting each ingredient allowing the
user to keep track of progress as well as ensuring quality of completion. Walkthru was originally intended to be a replacement for expensive auto repair manuals,
however, it quickly become evident that the powers of image recognition could allow for many different types of processes to be made into a Walkthru. Users use their iPhone camera to allow for image recognition of critical objects on each step. Once an object is recognized its critical areas are highlighted and specific instructions are given to help the user. Through Apple’s ARKit-3 a coordinate system allows for multiple object recognition and a seamless AR experience while guiding a user through a Walkthru. Have you ever been stumped by the infamous IKEA construction instructions? If so, Walkthru is the app for you! Walkthru is focused on thorough step-by-step instructions ensuring users can complete tasks no matter the experience.



## Installation

iOS:

```Place all files into xCode project
If using a local Apple computer ensure the phone is plugged into the computer.
Choose the device in the run destination menu
Code will run on device, and follow instructions on screen to desired WalkThru
```
For further instructions see [Apple's Documentation](https://developer.apple.com/documentation/xcode/running-your-app-in-the-simulator-or-on-a-device)
## Usage example

Here are some example images from users completing a process using Walkthru. As of now there are 3 preprogrammed WalkThrus:
Making a PeanutButter and Jelly sandwich, setting up Cadoo Deluxe Edition, and replacing the air filter on 2007 Kia Rondo.
Users are encourage to create their own Walkthrus if desired to help others through complex tasks, check below in Development setup for further instructions.
![Cadoo Image 1](https://github.com/SorenAndersen1/OSUCapstoneProject/blob/main/images/cadoo1.PNG?raw=true)
![Cadoo Image 2](https://github.com/SorenAndersen1/OSUCapstoneProject/blob/main/images/cadoo2.PNG?raw=true)
![Air Filter Image 1](https://github.com/SorenAndersen1/OSUCapstoneProject/blob/main/images/AirFilter1.PNG?raw=true)
![Air Filter Image 2](https://github.com/SorenAndersen1/OSUCapstoneProject/blob/main/images/AirFIlter2.PNG?raw=true)



## Development setup

Unfortunately Apple's xCode is only available on iOS products therefore Windows deveolpment is not available.
```
To create your own Walkthru simply create json file following the outline below, 
with each object being a single step which can contain up to 25 different photos.
Place premade JSON into ./multiIdentify/InstructionSets/
```
![JSON format](https://github.com/SorenAndersen1/OSUCapstoneProject/blob/main/images/screenshotcodeCapstone.PNG?raw=true)

```
Then add pictures of desired process that will act as images for the app to recognize
during the process to indivdual AR Resource Groups for each step. File name format 
is listed below, with all folders placed into ./multiIdentify/assets.xcassets/
```
![File Format](https://github.com/SorenAndersen1/OSUCapstoneProject/blob/main/images/ARFormat.PNG?raw=true)

```
Once completed follow installation instructions to install on a local device.
```

## Release History

* 1.0.1
  * Released WalkThru with Air Filter Repair, PB&J, and Cadoo setup as example Walkthrus

## Credit 

WalkThru is an App made for Oregon State University's senior Capstone Project course. Walkthru was created by 3 people: Soren Andersen, Claire Swanson, and Nowlen Webb. Claire focused on the classes necessary to develop the Walkthrus such as Step.Swift and InstructionText.Swift as well as the conversion to use JSON to store the premade Walkthru information. Soren developed all Walkthrus and the image recognition system, some of his code can be seen below. Nowlen designed all screens and developed the entire UI. See the meta section for each developers Github.
![Soren's Code](https://github.com/SorenAndersen1/OSUCapstoneProject/blob/main/images/SorenCode.PNG?raw=true)



## Meta

Soren Andersen – [SorenAndersen1](https://github.com/SorenAndersen1) – andesore@oregonstate.edu

Claire Swanson – [claireswn8](https://github.com/claireswn8) – swanscol@oregonstate.edu 

Nowlen Webb – [NowlenWebb](https://github.com/NowlenWebb) – webbjos@oregonstate.edu 

For more information contact Soren Andersen by email or on [Linked In](https://www.linkedin.com/in/soren-andersen-556492184/)

## Contributing

1. Fork it (<https://github.com/SorenAndersen1/OSUCapstoneProject/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

![Original Project Github](https://github.com/SorenAndersen1/capstoneproject/tree/main)
![Readme.md Formatting](https://github.com/dbader/readme-template)
