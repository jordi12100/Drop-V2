    //
//  AppDelegate.m
//  Drop
//
//  Created by Jordi Kroon on 8/13/16.
//  Copyright © 2016 Jordi Kroon. All rights reserved.
//
#import "AppDelegate.h"

@implementation AppDelegate

@synthesize statusItem, configurationInitializer, keybindInitializer, menuInitializer;

#pragma mark - Objc-C initializers
#pragma mark -

/**
 * @param aNotification
 */
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSDictionary *options = @{(__bridge id)kAXTrustedCheckOptionPrompt: @YES};
    if (!AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)options)) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"Ok"];
        [alert setMessageText:@"We need permissions"];
        [alert setInformativeText:@"Due to policy restrictions, shortcuts will not work until Accessibility has been granted and the app has been restarted."];
        [alert setAlertStyle:NSInformationalAlertStyle];
        [alert runModal];

        NSLog(@"Client did not accept accessibility permissions");
    }

    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    configurationInitializer = [[ConfigurationInitializer alloc] init];
    keybindInitializer = [[KeybindInitializer alloc] init];
    menuInitializer = [[MenuInitializer alloc] initWithStatusItem:statusItem];
    [menuInitializer buildMenu];
}

@end
