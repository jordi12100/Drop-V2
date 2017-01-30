//
//  PreferenceGeneralController.h
//  Drop
//
//  Created by Jordi Kroon on 11/19/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MASPreferences/MASPreferencesViewController.h>
#import "CCNLaunchAtLoginItem/CCNLaunchAtLoginItem.h"

@interface PreferenceGeneralController : NSViewController <MASPreferencesViewController>
@property (weak, nonatomic) IBOutlet NSButton *loginItemCheckbox;
@property (strong, nonatomic) CCNLaunchAtLoginItem *loginItem;
@end
