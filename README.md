# PitchPerfect
This iOS app allows the user to record and then playback audio with sound effects. It was submitted to Udacity as a project for their iOS Nanodegree Program. The project met specifications.

PitchPerfect was written in Swift 2.2

## Install

In order to run this app you will need Xcode 7.3. If using a personal iOS device, it will need to have iOS 9.2 or later installed.

1. Open `Pitch Perfect.xcodeproj` in Xcode
2. Build and run the project on the simulator or on a personal iOS device.

## Known Issues

There is an `Unable to simultaneously satisfy constraints` error when transitioning to the Play Sounds scene. This may be related to the microphone in use status bar which appears briefly during the transition. The resulting constraints conflict appears to be a reported bug.

From the user's perspective, the entire scene moves down and then back up during the transition.

## Attributions

All images in the `.xcassets` file were provided by Udacity with the following exceptions:

* The 83.5pt icon was created by modifying one of the existing icons

