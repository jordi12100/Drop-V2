//
// Created by Jordi Kroon on 11/13/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "PreferencesHandler.h"
#import "PreferenceGeneralController.h"
#import "PreferenceKeybindController.h"
#import "MASPreferencesWindowController.h"

@implementation PreferencesHandler

- (NSWindowController *)preferencesWindowController
{
    if (_preferencesWindowController == nil)
    {
        PreferenceGeneralController *preferenceGeneralController = [[PreferenceGeneralController alloc] init];
        PreferenceKeybindController *preferenceKeybindController = [[PreferenceKeybindController alloc] init];
        NSArray *controllers = @[preferenceGeneralController, preferenceKeybindController];

        NSString *title = @"Preferences";
        _preferencesWindowController = [[MASPreferencesWindowController alloc] initWithViewControllers:controllers title:title];
    }
    return _preferencesWindowController;
}

- (void)handle
{
    [self.preferencesWindowController showWindow:nil];
    [[self.preferencesWindowController window] setLevel: NSFloatingWindowLevel];
    [[self.preferencesWindowController window] makeKeyAndOrderFront:self];
    [[self.preferencesWindowController window] center];
    [NSApp activateIgnoringOtherApps:YES];
}

@end
