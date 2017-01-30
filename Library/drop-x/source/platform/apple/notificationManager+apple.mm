//
// Created by Jordi Kroon on 8/29/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#include "notificationManager+apple.hpp"

bool NotificationManager::send(Notification *notification)
{
    NSString *title = [NSString stringWithUTF8String:notification->getTitle().c_str()];
    NSString *message = [NSString stringWithUTF8String:notification->getMessage().c_str()];
    if (notification->getSoundName().empty()) {
        [notificationManager sendWithTitle:title andMessage:message];
    } else {
        NSString *soundName = [NSString stringWithUTF8String:notification->getSoundName().c_str()];
        [notificationManager sendWithTitle:title andMessage:message andSound: soundName];
    }

    return true;
}
