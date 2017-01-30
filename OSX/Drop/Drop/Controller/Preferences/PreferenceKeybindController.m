//
//  PreferenceKeybindController.m
//  Drop
//
//  Created by Jordi Kroon on 11/19/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#import "PreferenceKeybindController.h"

@interface PreferenceKeybindController ()

@end

@implementation PreferenceKeybindController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark MASPreferencesViewController

- (NSString *)identifier
{
    return @"KeybindPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNameAdvanced];
}

- (NSString *)toolbarItemLabel
{
    return @"Shortcuts";
}

@end
