# OpenGL Bug Repro

### Fixed Recently

This bug is now fixed in later versions like v1.11.1:

```
pod 'Google-Maps-iOS-SDK-for-Business', '~> 1.11.1'
```

### Summary

When an application adds a map instance while the app is in the background, the newly added map ends up being completely blank when the app is foregrounded.

This also happens if the map is released from memory during a long period of time in the background and has to be reinstantiated upon relaunch of the app. 

### Reason

The OpenGL renderer is not able to be run in the background (OS restrictions) and is not restarted once it's foregrounded.

Unfortunately developers cannot always control when the map instance is pushed out of memory and we should also be able to instantiate a map / view at any time, whether in the foreground or background. This should be properly handled by the Google Maps team instead of putting the map into an irrecoverable state.

### Fix

Restart the renderer once the application is foregrounded.

### Setup Steps

1. Clone and `cd` into the repo directory
2. Run `pod install` to install the Gmaps dependency
3. Open the sample app workspace file
4. Change the Bundle Identifier to one you have a Gmaps API key for and input the API key in the `ViewController` class

### Repro Steps

1. Press the `Show Map In Foreground` button to see that maps successfully load while the app is foregrounded
2. Press the `Show Map In Background` button, press `OK` and then background the app
3. Once the local notification is shown, tap it to relaunch the app
4. You will see the map is now blank except for the `Google` icon in the bottom left
5. Press the `Show Map In Foreground` button to see that once again the map loads just fine when it's instantiated in the foreground
