DragNavigationMenu
==================

A open source iOS control for navigation similar to the one used by groupon iOS app
// WORK IN PROGRESS !

To see the control in action download the repo and run the DragMenu.xcodeproj

In DGAppDelegate you will find the steps neccessary to use the control in your app.

You will need to copy the following from DragNavigationMenu to set up the control in your app:
1) DGNavigationController.h ,DGNavigationController.m
2) DGMenuItem.h , DGMenuItem.m
3) DGMenu.h , DGMenu.m
4) Copy the external components folder
5) Copy the all the fonts from the resources folder.

You will need to link your binary with the following libraries :
CoreText
QuartzCore
CoreGraphics


First create a set of menu items and associate each menu item 
