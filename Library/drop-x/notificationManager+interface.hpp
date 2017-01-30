//
// Created by Jordi Kroon on 8/29/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#ifndef DROP_X_NOTIFICATIONMANAGER_INTERFACE_HPP
#define DROP_X_NOTIFICATIONMANAGER_INTERFACE_HPP

#ifdef __cplusplus
    #include <string>
    #import "notification.hpp"
#endif

class NotificationManagerInterface
{
    public:
        /**
         * @param notification notification
         */
        virtual bool send(Notification *notification){return true;};
};

#endif //DROP_X_NOTIFICATIONMANAGER_HPP
