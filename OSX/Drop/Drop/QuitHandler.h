//
// Created by Jordi Kroon on 11/12/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "HandlerProtocol.h"

@interface QuitHandler : NSObject<HandlerProtocol>
- (void)handle;
@end