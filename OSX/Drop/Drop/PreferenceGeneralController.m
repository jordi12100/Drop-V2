//
//  PreferenceGeneralController.m
//  Drop
//
//  Created by Jordi Kroon on 11/19/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//

#import "PreferenceGeneralController.h"

@interface PreferenceGeneralController ()

@end

@implementation PreferenceGeneralController

@synthesize loginItemCheckbox;
@synthesize loginItem;

- (id)init
{
    return [super initWithNibName:@"PreferenceGeneralController" bundle:nil];
}

- (void)viewDidLoad
{
    self.loginItem = [CCNLaunchAtLoginItem itemForBundle:[NSBundle mainBundle]];
    self.loginItemCheckbox.state = ([self.loginItem isActive] ? NSOnState : NSOffState);

    [super viewDidLoad];
}

#pragma mark MASPreferencesViewController

- (NSString *)identifier
{
    return @"GeneralPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

- (NSString *)toolbarItemLabel
{
    return @"General";
}

- (IBAction)loginItemCheckboxDidChange:(id)sender {
    if ([sender state] == NSOnState) {
        [self.loginItem activate];
    } else {
        [self.loginItem deActivate];
    }
}

@end