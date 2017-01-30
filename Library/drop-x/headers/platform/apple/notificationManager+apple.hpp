//
// Created by Jordi Kroon on 8/29/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#ifndef DROP_X_NOTIFICATIONMANAGER_APPLE_HPP
#define DROP_X_NOTIFICATIONMANAGER_APPLE_HPP

#ifdef __cplusplus
    #import "notification.hpp"
    #import "notificationManager+interface.hpp"
    #import <string>
#endif

#import "AppleUserNotificationManager.h"

class NotificationManager : public NotificationManagerInterface
{
    private:
        /**
         * @var AppleUserNotificationManager
         */
        AppleUserNotificationManager *notificationManager = [[AppleUserNotificationManager alloc] init];

    public:
        /**
         * @param Notification notification
         */
        bool send(Notification *notification);
};

#endif //DROP_X_NOTIFICATIONMANAGER_HPP
