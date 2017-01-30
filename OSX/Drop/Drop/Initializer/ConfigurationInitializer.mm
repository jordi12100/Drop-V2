//
// Created by Jordi Kroon on 11/12/16.
// Copyright (c) 2016 Jordi Kroon. All rights reserved.
//

#import <sstream>
#import "ConfigurationInitializer.h"
#import "configuration.hpp"

using namespace std;

@implementation ConfigurationInitializer

/**
 * @return instancetype
 */
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        std::stringstream stdConfigFile;
        stdConfigFile << [self getConfigFolder] << [self getConfigName];

        Configuration::getInstance().setConfigFile(stdConfigFile.str());
        [self createConfigIfMissing];
    }

    return self;
}

- (void) createConfigIfMissing
{
    [self setDefaultConfigSettings];
}

/**
 * @param configFile
 */
- (void)setDefaultConfigSettings
{
    Configuration &configuration = Configuration::getInstance();

    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)@"CFBundleShortVersionString"];
    NSString *appBuildNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];

    configuration.put("Drop.App.Version", [appVersion UTF8String]);
    configuration.put("Drop.App.Build", [appBuildNumber UTF8String]);

    if (!configuration.exists("Drop.Screenshot.FileSystem.Output.Name")) {
        configuration.put("Drop.Screenshot.FileSystem.Output.Name", "screenshot.jpg");
    }

    if (!configuration.exists("Drop.Screenshot.FileSystem.Output.Folder")) {
        configuration.put("Drop.Screenshot.FileSystem.Output.Folder", [self getConfigFolder]);
    }

    if (!configuration.exists("Drop.Screenshot.Remote.Server")) {
        configuration.put("Drop.Screenshot.Remote.Server", "");
    }

    if (!configuration.exists("Drop.Screenshot.Type")) {
        configuration.put("Drop.Screenshot.Type", "jpg");
    }

    if (!configuration.exists("Drop.Bind.Upload.Modifiers")) {
        std::vector<int> configUploadBind = {NSControlKeyMask, NSShiftKeyMask};
        configuration.putArray("Drop.Bind.Upload.Modifiers", "Modifier", configUploadBind);
    }

    if (!configuration.exists("Drop.Bind.Upload.Key")) {
        configuration.put("Drop.Bind.Upload.Key", "8");
    }

    if (!configuration.exists("Drop.Bind.Clipboard.Modifiers")) {
        std::vector<int> configClipboardBind = {NSControlKeyMask, NSShiftKeyMask};
        configuration.putArray("Drop.Bind.Clipboard.Modifiers", "Modifier", configClipboardBind);
    }

    if (!configuration.exists("Drop.Bind.Clipboard.Key")) {
        configuration.put("Drop.Bind.Clipboard.Key", "32");
    }

    if (!configuration.exists("Drop.Bind.Notes.Modifiers")) {
        std::vector<int> configNotesBind = {NSControlKeyMask, NSShiftKeyMask};
        configuration.putArray("Drop.Bind.Notes.Modifiers", "Modifier", configNotesBind);
    }

    if (!configuration.exists("Drop.Bind.Notes.Key")) {
        configuration.put("Drop.Bind.Notes.Key", "45");
    }

    if (!configuration.exists("Drop.Gist.Token")) {
        configuration.put("Drop.Gist.Token", "");
    }
}

/**
 * @return string
 */
- (string) getConfigName
{
    return  "settings.xml";
}

/**
 * @return string
 */
- (string) getConfigFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *applicationSupportDirectory = [paths firstObject];
    NSString *path = [
        NSString stringWithFormat: @"%@/%@/",
        applicationSupportDirectory,
        [[NSBundle mainBundle] bundleIdentifier]
    ];

    return [path UTF8String];
}

@end