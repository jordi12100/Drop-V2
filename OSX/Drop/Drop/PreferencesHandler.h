//
// Created by Jordi Kroon on 11/13/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HandlerProtocol.h"
#import "configuration.hpp"

@interface PreferencesHandler : NSObject<HandlerProtocol> {
    NSWindow *_window;
    NSWindowController *_preferencesWindowController;
}

@property (nonatomic, strong) NSWindow* preferenceWindow;
@property (nonatomic, readonly) NSWindowController *preferencesWindowController;

- (void)handle;
@end