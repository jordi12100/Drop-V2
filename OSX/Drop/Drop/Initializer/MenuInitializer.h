//
// Created by Jordi Kroon on 11/12/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface MenuInitializer : NSObject

@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) NSTimer *animationTimer;
@property (readwrite, nonatomic) int currentFrame;

- (instancetype)initWithStatusItem:(NSStatusItem *)aStatusItem;
- (void) buildMenu;
@end