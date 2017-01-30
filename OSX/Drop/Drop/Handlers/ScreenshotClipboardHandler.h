//
// Created by Jordi Kroon on 11/13/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HandlerProtocol.h"
#import "screenshot.hpp"
#import <boost/bind.hpp>
#import "notification.hpp"
#import "uploadhandler.hpp"
#import "clipboard.hpp"
#import "notificationManager.hpp"
#import "configuration.hpp"

@interface ScreenshotClipboardHandler : NSObject<HandlerProtocol>
- (void)handle;
@end