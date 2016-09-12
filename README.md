# Pre-work - *Code Path Tip Calculator*

**Code Path Tip Calculator** is a tip calculator application for iOS.

Submitted by: **Minnie Lai**

Time spent: **5** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

* [x] Allowing the user to go back to the main app from Settings screen
* [x] Background images
* [x] App icons

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src="http://i.imgur.com/2mgscb6.gif" title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I found that putting all of the states in the `NSUserDefaults` was tedious and somewhat of an anti-pattern. I know that the delegate pattern is often used in iOS development, but unfortunately I am not familiar withit and thus depended on `NSUserDefaults` to keep track of the background image selection and default tip.

I would have liked to put the locale selection directly in the settings page and come up with a better UI for the choices. 

## License

    Copyright [2016] [Minnie Lai]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.