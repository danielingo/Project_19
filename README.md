# Project_19
# JD 2200: Lidar scan that allows you to view and test out different objects in various lidar view scenes.
## Version 0.5.0
### Features:
  * User can toggle camera on or off in AR view
  * User can use buttons to increase or decrease a prop's height
  * User can import LiDAR scan on set creation
### Bug Fixes:
  * User was previously not able to select or delete props in a set but is able to now
  * Bug that prevented user from replacing a set which was fixed
  * Bug where user could select multiple props/sets at once was fixed
### Known Issues:
  * Props currently do not appear in their relative locations in the set for the user when the set loads
  * The scene won't be to scale sometimes when anchored, user may need to reset and place a couple times before an adequately scaled scene is loaded in
  * User currently cannot import or delete props
## Version 0.4.0
### Features:
  * User can access and search through a list of props in the set environment
  * User can place objects from Prop Library and Sets from the Set Library into an open scene 
  * User can add a set to the set list that is linked to Firebase 
  * User can organize sets using tag selection 
### Bug Fixes:
  * User was not able to cancel when creating a new set
  * User was not able to confirm set creation via the done button
  * User was not able to select proper tag for list to organize sets
  * User could not see updated tags when tags were selected
## Version 0.3.0
### Features: 
  * User can select props in the augmented reality view
  * User can view the UI elements in augmented reality view making it a visually stimulating experience for when the user enters the app
  * User can select "add" button in order for set to be saved into firebase
### Bug Fixes:
  * User was not able to save newly created set. Fixed by saving to firebase storage
  * User was not able to view all tags when creating new set. Fixed by adding scroll view to tag list
### Known Issues:
  * User cannot login because Google Authentication crashing when attempting to connect 
## Version 0.2.0
### Features: 
  * Configured and connected the app to the fire base
  * Added cloud storage to the fire base project
  * Created the navigation bar
  * Recreated the dynamic set list view using swift storyboards.
### Bug Fixes: 
  * Fixed the set list view as it wasn’t working as planned in sprint 1
  * We were unable to integrate the storyboard features with the ARView
## Version 0.1.0
### New Feature
  * User will have access to their customized set lists 
### Bug Fixes
  * There are currently no bug fixes
