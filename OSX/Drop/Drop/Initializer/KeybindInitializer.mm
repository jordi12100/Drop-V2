//
// Created by Jordi Kroon on 11/13/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import "KeybindInitializer.h"
#import "keybinder.hpp"
#import "../Handlers/NotesHandler.h"
#import "../Handlers/ScreenshotClipboardHandler.h"
#import "../Handlers/ScreenshotUploadHandler.h"
#import "../AppDelegate.h"
#import <boost/bind.hpp>

Keybinder *keybinder = new Keybinder;

@implementation KeybindInitializer

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onConfigurationChanged:)
            name:ConfigurationDidChange object:nil];

        [self onConfigurationChanged: nil];
        keybinder->listen();
    }

    return self;
}

- (void) onConfigurationChanged:(NSNotification *) notification
{
    Configuration &configuration = Configuration::getInstance();

    keybinder->clearBinds();

    keybinder->addBind(
        configuration.getArray("Drop.Bind.Upload.Modifiers"),
        std::atoi(configuration.get("Drop.Bind.Upload.Key").c_str()),
        boost::bind(&onUploadKeyPressed)
    );

    keybinder->addBind(
        configuration.getArray("Drop.Bind.Clipboard.Modifiers"),
        std::atoi(configuration.get("Drop.Bind.Clipboard.Key").c_str()),
        boost::bind(&onClipboardKeyPressed)
    );

    keybinder->addBind(
        configuration.getArray("Drop.Bind.Notes.Modifiers"),
        std::atoi(configuration.get("Drop.Bind.Notes.Key").c_str()),
        boost::bind(&onNotesKeyPressed)
    );
}

void onUploadKeyPressed()
{
    [[[ScreenshotUploadHandler alloc] init] handle];
}

void onClipboardKeyPressed()
{
    [[[ScreenshotClipboardHandler alloc] init] handle];
}

void onNotesKeyPressed()
{
    [[[NotesHandler alloc] init] handle];
}

@end
