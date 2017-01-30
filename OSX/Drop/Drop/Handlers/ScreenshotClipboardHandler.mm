//
// Created by Jordi Kroon on 11/13/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import "ScreenshotClipboardHandler.h"

@implementation ScreenshotClipboardHandler

- (void)handle
{
    Configuration &configuration = Configuration::getInstance();

    Screenshot *screenshot = new Screenshot;
    screenshot->setImageName(configuration.get("Drop.Screenshot.FileSystem.Output.Name"));
    screenshot->setImageType(configuration.get("Drop.Screenshot.Type"));
    screenshot->setOutputFolder(configuration.get("Drop.Screenshot.FileSystem.Output.Folder"));

    screenshot->capture(boost::bind<void>(&onClipboardScreenshotCaptured, screenshot));
}

/**
 * @param screenshot
 */
void onClipboardScreenshotCaptured(Screenshot *screenshot)
{
    File *file = screenshot->getScreenshot();
    NSLog(@"Screenshot captured callback: %s in folder: %s", file->getFileName().c_str(), file->getFolderPath().c_str());

    Clipboard *clipboard = new Clipboard;
    clipboard->setImageFromPath(file->getFilePath());

    Notification *notification = new Notification;
    notification->setTitle("Drop");
    notification->setMessage("Screenshot copied to clipboard");

    NotificationManager *notificationManager = new NotificationManager;
    notificationManager->send(notification);
}
@end