//
// Created by Jordi Kroon on 8/30/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface AppleUserNotificationManager : NSObject <NSUserNotificationCenterDelegate>

@property (retain) NSUserNotification *userNotification;

- (void)sendWithTitle:(NSString *)title andMessage:(NSString *)message;
- (void)sendWithTitle:(NSString *)title andMessage:(NSString *)message andSound:(NSString *)soundName;

@end