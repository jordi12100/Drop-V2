//
//  AppDelegate.h
//  Drop
//
//  Created by Jordi Kroon on 10/9/16.
//  Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#define __drop

#import <Cocoa/Cocoa.h>
#import "MenuInitializer.h"
#import "KeybindInitializer.h"
#import "ConfigurationInitializer.h"

static NSString *const ConfigurationDidChange = @"configurationDidChange";
static NSString *const SpinningShouldStart = @"SpinningShouldStart";
static NSString *const SpinningShouldStop = @"SpinningShouldStop";

@interface AppDelegate : NSObject <NSApplicationDelegate>
    @property (strong, nonatomic) NSStatusItem *statusItem;
    @property (retain, nonatomic) ConfigurationInitializer *configurationInitializer;
    @property (retain, nonatomic) KeybindInitializer *keybindInitializer;
    @property (retain, nonatomic) MenuInitializer *menuInitializer;
@end
