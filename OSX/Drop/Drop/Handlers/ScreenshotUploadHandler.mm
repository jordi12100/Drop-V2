//
// Created by Jordi Kroon on 11/13/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import "ScreenshotUploadHandler.h"

@implementation ScreenshotUploadHandler

- (void)handle
{
    Configuration &configuration = Configuration::getInstance();

    Screenshot *screenshot = new Screenshot;
    screenshot->setImageName(configuration.get("Drop.Screenshot.FileSystem.Output.Name"));
    screenshot->setImageType(configuration.get("Drop.Screenshot.Type"));
    screenshot->setOutputFolder(configuration.get("Drop.Screenshot.FileSystem.Output.Folder"));

    screenshot->capture(boost::bind<void>(&onScreenshotCaptured, screenshot));
}

/**
 * @param screenshot
 */
void onScreenshotCaptured(Screenshot *screenshot)
{
    Configuration &configuration = Configuration::getInstance();

    File *file = screenshot->getScreenshot();
    NSLog(@"Screenshot captured callback: %s in folder: %s", file->getFileName().c_str(), file->getFolderPath().c_str());

    Notification *notification = new Notification;
    notification->setTitle("Drop");

    NSLog(@"Target server: %s", configuration.get("Drop.Screenshot.Remote.Server").c_str());

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:SpinningShouldStart object:nil];

        UploadHandler *uploadHandler = new UploadHandler;
        if (!uploadHandler->uploadFile(configuration.get("Drop.Screenshot.Remote.Server"), file)) {
            notification->setMessage("Upload failed");
        } else {
            Clipboard *clipboard = new Clipboard;
            clipboard->setText(uploadHandler->getPublicPath());

            notification->setMessage(uploadHandler->getPublicPath());
        }

        NotificationManager *notificationManager = new NotificationManager;
        notificationManager->send(notification);

        [[NSNotificationCenter defaultCenter] postNotificationName:SpinningShouldStop object:nil];
    });
}


@end
